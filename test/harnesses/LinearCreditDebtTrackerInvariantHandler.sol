// SPDX-License-Identifier: BUSL-1.1

/*
    This file is part of the Onyx Protocol.

    (c) Enzyme Foundation <foundation@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";

import {LinearCreditDebtTracker} from "src/components/value/position-trackers/LinearCreditDebtTracker.sol";
import {Shares} from "src/shares/Shares.sol";

contract LinearCreditDebtTrackerInvariantHandler is Test {
    LinearCreditDebtTracker public immutable tracker;
    Shares public immutable shares;
    address public immutable admin;

    constructor(LinearCreditDebtTracker _tracker, Shares _shares, address _admin) {
        tracker = _tracker;
        shares = _shares;
        admin = _admin;
    }

    function addItem(int128 _totalValue, uint40 _start, uint32 _duration) external {
        // sanitize inputs to avoid trivial reverts and overflow
        if (_totalValue == 0) {
            _totalValue = 1;
        }

        vm.prank(admin);
        // ignore description fuzzing for gas; constant string is fine
        try tracker.addItem({_totalValue: _totalValue, _start: _start, _duration: _duration, _description: ""}) {
        } catch {}
    }

    function removeRandom(uint256 _seed) external {
        uint24[] memory ids = tracker.getItemIds();
        if (ids.length == 0) {
            return;
        }

        uint256 idx = _seed % ids.length;
        uint24 id = ids[idx];

        vm.prank(admin);
        try tracker.removeItem({_id: id}) {
        } catch {}
    }

    function updateRandomSettled(uint256 _seed, int128 _totalSettled) external {
        uint24[] memory ids = tracker.getItemIds();
        if (ids.length == 0) {
            return;
        }

        uint256 idx = _seed % ids.length;
        uint24 id = ids[idx];

        vm.prank(admin);
        try tracker.updateSettledValue({_id: id, _totalSettled: _totalSettled}) {
        } catch {}
    }
}

