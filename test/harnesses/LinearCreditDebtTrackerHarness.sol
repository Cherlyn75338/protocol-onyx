// SPDX-License-Identifier: BUSL-1.1

/*
    This file is part of the Onyx Protocol.

    (c) Enzyme Foundation <foundation@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity ^0.8.0;

import {LinearCreditDebtTracker} from "src/components/value/position-trackers/LinearCreditDebtTracker.sol";
import {ComponentHarnessMixin} from "test/harnesses/utils/ComponentHarnessMixin.sol";

contract LinearCreditDebtTrackerHarness is LinearCreditDebtTracker, ComponentHarnessMixin {
    constructor(address _shares) ComponentHarnessMixin(_shares) {}

    /// @notice Test-only helper to set lastItemId near bounds for overflow testing
    function harness_setLastItemId(uint24 _id) external {
        // Mirror storage accessor locally to set the namespaced storage slot
        bytes32 location =
            0xf3c5e97ea0f49b3293469a3b3dca5503879e1f21da2c7f1e770e480cdbe07300; // LINEAR_CREDIT_DEBT_TRACKER_STORAGE_LOCATION
        assembly {
            // slot 0 of the namespaced struct stores packed fields starting with uint24 lastItemId
            // mask lower 24 bits only
            let masked := or(and(sload(location), not(0xFFFFFF)), _id)
            sstore(location, masked)
        }
    }
}
