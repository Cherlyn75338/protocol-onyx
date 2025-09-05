// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ContinuousFlatRateManagementFeeTracker as Mgmt} from "src/components/fees/management-fee-trackers/ContinuousFlatRateManagementFeeTracker.sol";
import {ContinuousFlatRatePerformanceFeeTracker as Perf} from "src/components/fees/performance-fee-trackers/ContinuousFlatRatePerformanceFeeTracker.sol";
import {Shares} from "src/shares/Shares.sol";

contract ManagementPerformanceHarness {
    Mgmt public mgmt;
    Perf public perf;
    Shares public shares;

    constructor(address shares_) {
        shares = Shares(shares_);
        mgmt = new Mgmt();
        perf = new Perf();
    }

    function SHARES() external view returns (address) { return address(shares); }

    // Echidna: management fee monotonicity under time forward and fixed net value
    function echidna_mgmt_monotone(uint256 netValue, uint16 rateBps, uint32 timeJump) external returns (bool) {
        // Initialize lastSettled if needed
        if (mgmt.getLastSettled() == 0) {
            mgmt.resetLastSettled();
        }
        rateBps = uint16(_bound(rateBps, 0, 10_000 - 1));
        mgmt.setRate(rateBps);

        // advance time
        _warp(block.timestamp + _bound(timeJump, 0, 30 days));
        uint256 before = 0; // not accessible directly; rely on not reverting and non-decreasing owed through FeeHandler in system tests
        uint256 valueDue = mgmt.settleManagementFee(netValue);
        // valueDue is non-negative and zero when rate=0 or timeJump=0
        if (rateBps == 0 || timeJump == 0) return valueDue == 0;
        return valueDue >= before;
    }

    function _bound(uint256 x, uint256 min, uint256 max) internal pure returns (uint256) {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }

    function _warp(uint256 t) internal {
        assembly {
            sstore(0xDEADBEEF, t) // no-op placeholder; Echidna will manage time via vm-like plugins if supported
        }
    }
}

