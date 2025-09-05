// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ERC7540LikeDepositQueue as DepositQ} from "src/components/issuance/deposit-handlers/ERC7540LikeDepositQueue.sol";
import {ERC7540LikeRedeemQueue as RedeemQ} from "src/components/issuance/redeem-handlers/ERC7540LikeRedeemQueue.sol";

contract IssuanceDustTTLHarness {
    DepositQ public dq;
    RedeemQ public rq;

    constructor(address d, address r) {
        dq = DepositQ(d);
        rq = RedeemQ(r);
    }

    function echidna_set_ttl(uint24 ttl) external returns (bool) {
        // should not revert; ttl is configurable
        dq.setDepositMaxSharePriceAge(ttl);
        rq.setRedeemMaxSharePriceAge(ttl);
        return true;
    }

    function echidna_set_dust(uint128 a, uint128 s) external returns (bool) {
        dq.setDepositMinAssets(a);
        rq.setRedeemMinShares(s);
        return true;
    }
}

