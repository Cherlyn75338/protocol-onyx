#!/usr/bin/env python3
import json
import os
import sys
from dataclasses import dataclass
from typing import Any, Dict, List, Optional
from urllib import request
from urllib.error import URLError, HTTPError


DEFAULT_RPC = os.environ.get("SUI_RPC_URL", "https://fullnode.mainnet.sui.io:443")
LENDING_PKG = os.environ.get(
    "LENDING_PKG",
    "0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca",
)
ORACLE_PKG = os.environ.get(
    "ORACLE_PKG",
    "0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f",
)


def rpc_call(rpc_url: str, method: str, params: List[Any]) -> Any:
    payload = json.dumps({"jsonrpc": "2.0", "id": 1, "method": method, "params": params}).encode()
    req = request.Request(rpc_url, data=payload, headers={"Content-Type": "application/json"})
    try:
        with request.urlopen(req, timeout=60) as resp:
            data = json.loads(resp.read().decode())
            if "error" in data:
                raise RuntimeError(f"RPC error {method}: {data['error']}\nRPC URL: {rpc_url}")
            return data.get("result")
    except (URLError, HTTPError) as e:
        raise RuntimeError(f"RPC failed {method}: {e}\nRPC URL: {rpc_url}")


def get_latest_time_ms(rpc_url: str) -> int:
    seq = rpc_call(rpc_url, "sui_getLatestCheckpointSequenceNumber", [])
    chk = rpc_call(rpc_url, "sui_getCheckpoint", [seq])
    return int(chk["timestampMs"])  # ms


def has_suix(rpc_url: str) -> bool:
    try:
        rpc_call(rpc_url, "suix_getMultipleClosedObjects", [["0x0"]])
        return True
    except Exception:
        # Method missing or invalid params => assume no suix
        return False


def suix_query_by_struct(rpc_url: str, struct_type: str, limit: int = 200) -> List[Dict[str, Any]]:
    # Uses suix_queryObjects with StructType filter
    cursor = None
    out: List[Dict[str, Any]] = []
    while True:
        params = [
            {
                "filter": {"StructType": struct_type},
                "options": {"showType": True, "showOwner": True, "showContent": True},
                "cursor": cursor,
                "limit": min(50, limit),
            }
        ]
        res = rpc_call(rpc_url, "suix_queryObjects", params)
        data = res.get("data", [])
        out.extend(data)
        cursor = res.get("nextCursor")
        if not cursor or len(out) >= limit:
            break
    return out


def suix_query_by_package(rpc_url: str, package: str, limit: int = 1000) -> List[Dict[str, Any]]:
    cursor = None
    out: List[Dict[str, Any]] = []
    while True:
        params = [
            {
                "filter": {"Package": package},
                "options": {"showType": True, "showOwner": True, "showContent": True},
                "cursor": cursor,
                "limit": min(200, limit),
            }
        ]
        res = rpc_call(rpc_url, "suix_queryObjects", params)
        data = res.get("data", [])
        out.extend(data)
        cursor = res.get("nextCursor")
        if not cursor or len(out) >= limit:
            break
    return out


def list_dynamic_fields(rpc_url: str, parent_id: str, limit: int = 500) -> List[Dict[str, Any]]:
    out: List[Dict[str, Any]] = []
    cursor: Optional[str] = None
    while True:
        res = rpc_call(
            rpc_url,
            "suix_getDynamicFields",
            [{"parentId": parent_id, "cursor": cursor, "limit": min(50, limit)}],
        )
        out.extend(res.get("data", []))
        cursor = res.get("nextCursor")
        if not cursor or len(out) >= limit:
            break
    return out


def get_dynamic_value(rpc_url: str, parent_id: str, name: Dict[str, Any]) -> Dict[str, Any]:
    return rpc_call(rpc_url, "suix_getDynamicFieldObject", [{"parentId": parent_id, "name": name}])


def main() -> int:
    rpc_url = DEFAULT_RPC
    report: Dict[str, Any] = {
        "rpc": rpc_url,
        "lending_package": LENDING_PKG,
        "oracle_package": ORACLE_PKG,
        "suix_available": False,
        "chain_time_ms": None,
        "price_oracles": [],
        "storages": [],
        "pools": [],
        "notes": [],
    }

    try:
        report["chain_time_ms"] = get_latest_time_ms(rpc_url)
    except Exception as e:
        report["notes"].append(f"Failed to fetch latest checkpoint time: {e}")

    if not has_suix(rpc_url):
        report["notes"].append(
            "RPC endpoint does not support suix_* indexer methods. Set SUI_RPC_URL to an indexer-enabled RPC (e.g., RPC provider with suix support)."
        )
        print(json.dumps(report, indent=2))
        # Still write to file for consistency
        out_path = os.environ.get("OUT", "/workspace/_audit/sui/spotcheck.json")
        try:
            os.makedirs(os.path.dirname(out_path), exist_ok=True)
            with open(out_path, "w") as f:
                json.dump(report, f, indent=2)
            print(f"Wrote {out_path}")
        except Exception as e:
            print(f"Failed to write report: {e}")
        return 2

    report["suix_available"] = True

    # Query PriceOracle objects
    try:
        oracles = suix_query_by_struct(rpc_url, f"{ORACLE_PKG}::oracle::PriceOracle", limit=50)
        for o in oracles:
            di = o.get("data", {})
            oid = di.get("objectId")
            content = di.get("content", {})
            fields = content.get("fields", {}) if content else {}
            update_interval = fields.get("update_interval")
            price_tbl = None
            if fields.get("price_oracles"):
                price_tbl = (
                    fields["price_oracles"].get("fields", {}).get("id", {}).get("id")
                )
            entry: Dict[str, Any] = {
                "objectId": oid,
                "update_interval": update_interval,
                "price_table": price_tbl,
                "assets": [],
            }
            if price_tbl and report["chain_time_ms"] is not None:
                dfields = list_dynamic_fields(rpc_url, price_tbl, limit=200)
                keys: List[int] = []
                for df in dfields:
                    name = df.get("name")
                    if isinstance(name, dict) and name.get("type") == "u8":
                        keys.append(name["value"])  # asset_id
                for k in sorted(set(keys))[:20]:
                    try:
                        val_obj = get_dynamic_value(rpc_url, price_tbl, {"type": "u8", "value": k})
                        vdata = val_obj.get("data", {}).get("content", {})
                        vfields = vdata.get("fields", {}) if vdata else {}
                        value_fields = vfields.get("value", {}).get("fields", {}) if "value" in vfields else {}
                        price = value_fields.get("value")
                        decimals = value_fields.get("decimal")
                        ts = value_fields.get("timestamp")
                        staleness_ms = None
                        fresh_ok = None
                        if ts is not None and report["chain_time_ms"] is not None:
                            staleness_ms = int(report["chain_time_ms"]) - int(ts)
                            if update_interval is not None:
                                fresh_ok = staleness_ms <= int(update_interval)
                        entry["assets"].append(
                            {
                                "asset_id": k,
                                "price": price,
                                "decimals": decimals,
                                "timestamp": ts,
                                "staleness_ms": staleness_ms,
                                "fresh_ok": fresh_ok,
                            }
                        )
                    except Exception as e:
                        entry["assets"].append({"asset_id": k, "error": str(e)})
            report["price_oracles"].append(entry)
    except Exception as e:
        report["notes"].append(f"Failed querying PriceOracle objects: {e}")

    # Query Storage objects and reserves
    try:
        storages = suix_query_by_struct(rpc_url, f"{LENDING_PKG}::storage::Storage", limit=50)
        for s in storages:
            di = s.get("data", {})
            oid = di.get("objectId")
            content = di.get("content", {})
            fields = content.get("fields", {}) if content else {}
            reserves_tbl = None
            if fields.get("reserves"):
                reserves_tbl = (
                    fields["reserves"].get("fields", {}).get("id", {}).get("id")
                )
            reserves_count = fields.get("reserves_count")
            storage_entry: Dict[str, Any] = {
                "objectId": oid,
                "reserves_table": reserves_tbl,
                "reserves_count": reserves_count,
                "reserves": [],
            }
            if reserves_tbl:
                rf = list_dynamic_fields(rpc_url, reserves_tbl, limit=200)
                keys: List[int] = []
                for df in rf:
                    name = df.get("name")
                    if isinstance(name, dict) and name.get("type") == "u8":
                        keys.append(name["value"])  # asset_id
                for k in sorted(set(keys))[:50]:
                    try:
                        val_obj = get_dynamic_value(rpc_url, reserves_tbl, {"type": "u8", "value": k})
                        vdata = val_obj.get("data", {}).get("content", {})
                        vfields = vdata.get("fields", {}) if vdata else {}
                        reserve = vfields.get("value", {}).get("fields", {}) if "value" in vfields else {}
                        coin_type = reserve.get("coin_type")
                        ltv = reserve.get("ltv")
                        liq = reserve.get("liquidation_factors", {}).get("fields", {}) if reserve.get("liquidation_factors") else {}
                        borrow_cap = reserve.get("borrow_cap_ceiling")
                        supply_cap = reserve.get("supply_cap_ceiling")
                        treasury_factor = reserve.get("treasury_factor")
                        last_update = reserve.get("last_update_timestamp")
                        storage_entry["reserves"].append(
                            {
                                "asset_id": k,
                                "coin_type": coin_type,
                                "ltv": ltv,
                                "liquidation_ratio": liq.get("ratio"),
                                "liquidation_bonus": liq.get("bonus"),
                                "liquidation_threshold": liq.get("threshold"),
                                "borrow_cap": borrow_cap,
                                "supply_cap": supply_cap,
                                "treasury_factor": treasury_factor,
                                "last_update_ts": last_update,
                            }
                        )
                    except Exception as e:
                        storage_entry["reserves"].append({"asset_id": k, "error": str(e)})
            report["storages"].append(storage_entry)
    except Exception as e:
        report["notes"].append(f"Failed querying Storage objects: {e}")

    # Query pools by package and filter type name
    try:
        objs = suix_query_by_package(rpc_url, LENDING_PKG, limit=2000)
        for o in objs:
            di = o.get("data", {})
            typ = di.get("type")
            if isinstance(typ, str) and f"{LENDING_PKG}::pool::Pool<" in typ:
                content = di.get("content", {})
                fields = content.get("fields", {}) if content else {}
                report["pools"].append(
                    {
                        "objectId": di.get("objectId"),
                        "type": typ,
                        "decimal": fields.get("decimal"),
                    }
                )
    except Exception as e:
        report["notes"].append(f"Failed querying Pool objects: {e}")

    # Write report
    out_path = os.environ.get("OUT", "/workspace/_audit/sui/spotcheck.json")
    try:
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        with open(out_path, "w") as f:
            json.dump(report, f, indent=2)
        print(f"Wrote {out_path}")
    except Exception as e:
        print(f"Failed to write report: {e}")
        print(json.dumps(report, indent=2))
        return 1

    # Print concise summary to stdout
    print(
        json.dumps(
            {
                "rpc": report["rpc"],
                "suix_available": report["suix_available"],
                "oracles": len(report["price_oracles"]),
                "storages": len(report["storages"]),
                "pools": len(report["pools"]),
                "notes": report.get("notes", []),
            },
            indent=2,
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())

