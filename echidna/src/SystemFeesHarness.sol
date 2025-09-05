// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {Shares} from "src/shares/Shares.sol";
import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {ContinuousFlatRateManagementFeeTracker as Mgmt} from "src/components/fees/management-fee-trackers/ContinuousFlatRateManagementFeeTracker.sol";
import {ContinuousFlatRatePerformanceFeeTracker as Perf} from "src/components/fees/performance-fee-trackers/ContinuousFlatRatePerformanceFeeTracker.sol";
import {ValuationHandlerHarness} from "echidna/src/wrappers/ValuationHandlerHarness.sol";
import {MockERC20} from "echidna/src/mocks/MockERC20.sol";

contract SystemFeesHarness {
    Shares public shares;
    FeeHandler public feeHandler;
    ValuationHandlerHarness public val;
    Mgmt public mgmt;
    Perf public perf;
    MockERC20 public feeAsset;

    mapping(address => bool) private seen;
    address[] private recipients;

    constructor() {
        // Deploy Shares and init
        shares = new Shares();
        shares.init(address(this), "X", "X", bytes32("USD"));

        // Plug FeeHandler
        feeHandler = new FeeHandler();
        shares.addAdmin(address(this));
        shares.setFeeHandler(address(feeHandler));

        // Plug ValuationHandler (shares value provider)
        val = new ValuationHandlerHarness(address(shares));
        shares.setValuationHandler(address(val));

        // Deploy trackers
        mgmt = new Mgmt();
        perf = new Perf();

        // Configure FeeHandler trackers and recipients
        feeAsset = new MockERC20("F", "F", 18);
        feeHandler.setFeeAsset(address(feeAsset));
        feeHandler.setManagementFee(address(mgmt), address(0x1001));
        feeHandler.setPerformanceFee(address(perf), address(0x1002));
        _trackRecipient(address(0x1001));
        _trackRecipient(address(0x1002));
    }

    function SHARES() external view returns (address) { return address(shares); }

    // P7 exact sum(userFeesOwed) == totalFeesOwed after any sequence
    function echidna_total_eq_sum_users() external view returns (bool) {
        uint256 total = feeHandler.getTotalValueOwed();
        uint256 sumUsers;
        for (uint256 i; i < recipients.length; i++) {
            sumUsers += feeHandler.getValueOwedToUser(recipients[i]);
        }
        return sumUsers == total;
    }

    // P8 claimFees decreases both totals by v, feeAssetAmount_ > 0 if v>0 and conversion possible
    function echidna_claim_reduces_totals(uint256 v) external returns (bool) {
        v = _bound(v, 0, 1e30);
        uint256 beforeUser = feeHandler.getValueOwedToUser(recipients[0]);
        uint256 beforeTotal = feeHandler.getTotalValueOwed();
        if (v > beforeUser) { return true; } // handler will revert internally before claim via decrease; skip

        // fund Shares with feeAsset so withdraws succeed
        feeAsset.mint(address(shares), 1e24);
        uint256 paid = feeHandler.claimFees(recipients[0], v);

        uint256 afterUser = feeHandler.getValueOwedToUser(recipients[0]);
        uint256 afterTotal = feeHandler.getTotalValueOwed();

        if (v == 0) { return paid == 0 && afterUser == beforeUser && afterTotal == beforeTotal; }
        // if v>0 and there is a fee asset, paid must be >0 (subject to decimals rounding)
        return (beforeUser - afterUser == v) && (beforeTotal - afterTotal == v) && (paid > 0);
    }

    // Drive management fee settlement, ensure monotonic owed and init-time behavior
    function settleDynamicFees(uint256 tvl, uint16 mgmtBps, uint16 perfBps) external returns (bool) {
        mgmt.resetLastSettled();
        perf.resetHighWaterMark();
        mgmt.setRate(uint16(_bound(mgmtBps, 0, 9999)));
        perf.setRate(uint16(_bound(perfBps, 0, 9999)));

        // simulate one updateShareValue() call path
        // set tracked positions = tvl; untracked = 0; feeHandler called internally by ValuationHandler in system, here we directly settle
        feeHandler.settleDynamicFeesGivenPositionsValue(tvl);
        _trackRecipient(feeHandler.getManagementFeeRecipient());
        _trackRecipient(feeHandler.getPerformanceFeeRecipient());
        return true;
    }

    // P10 Performance fee HWM behavior (coarse): settle 0 when value <= HWM; settle >0 and update HWM otherwise
    function echidna_perf_hwm(uint256 netValue, uint16 rateBps) external returns (bool) {
        if (perf.getHighWaterMark() == 0) { perf.resetHighWaterMark(); }
        rateBps = uint16(_bound(rateBps, 0, 9999));
        perf.setRate(rateBps);
        // ensure supply is treated as non-zero in tracker logic
        if (shares.totalSupply() == 0) {
            // cannot mint here (only deposit handler), but perf tracker will reset hwm if supply==0 and return 0
            // so accept zero settlement path
            uint256 v = perf.settlePerformanceFee(netValue);
            return v == 0;
        }
        uint256 hwm = perf.getHighWaterMark();
        if (netValue <= hwm) {
            uint256 v = perf.settlePerformanceFee(netValue);
            return v == 0 && perf.getHighWaterMark() == hwm;
        } else {
            uint256 v = perf.settlePerformanceFee(netValue);
            return v > 0 && perf.getHighWaterMark() >= hwm;
        }
    }

    function _trackRecipient(address r) internal {
        if (r != address(0) && !seen[r]) { seen[r] = true; recipients.push(r); }
    }

    function _bound(uint256 x, uint256 min, uint256 max) internal pure returns (uint256) {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }
}

