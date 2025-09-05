// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {Shares} from "src/shares/Shares.sol";
import {IERC20Metadata as IERC20} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/// @notice A simple harness that instantiates Shares + FeeHandler and exposes invariants for Echidna
contract FeeHandlerHarness is FeeHandler {
    // Use a minimal Shares proxy-like interface via ComponentHelpersMixin (__getShares())
    address private immutable SHARES_FAKE;

    constructor(address shares_) {
        SHARES_FAKE = shares_;
    }

    function SHARES() external view returns (address) { return SHARES_FAKE; }

    // For Echidna: sum of per-user owed should never exceed total owed; equality is maintained by internal helpers
    function echidna_sum_le_total(address u1, address u2, address u3) external view returns (bool) {
        uint256 total = getTotalValueOwed();
        uint256 s = getValueOwedToUser(u1) + getValueOwedToUser(u2) + getValueOwedToUser(u3);
        return s <= total;
    }
}

