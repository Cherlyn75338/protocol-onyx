// SPDX-License-Identifier: BUSL-1.1

/*
    This file is part of the Onyx Protocol.

    (c) Enzyme Foundation <foundation@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.28;

import {StdInvariant} from "forge-std/StdInvariant.sol";
import {Test} from "forge-std/Test.sol";

import {LinearCreditDebtTracker} from "src/components/value/position-trackers/LinearCreditDebtTracker.sol";
import {Shares} from "src/shares/Shares.sol";

import {LinearCreditDebtTrackerHarness} from "test/harnesses/LinearCreditDebtTrackerHarness.sol";
import {LinearCreditDebtTrackerInvariantHandler} from "test/harnesses/LinearCreditDebtTrackerInvariantHandler.sol";
import {TestHelpers} from "test/utils/TestHelpers.sol";

contract LinearCreditDebtTrackerInvariants is StdInvariant, Test, TestHelpers {
    Shares shares;
    address owner;
    address admin = makeAddr("admin");

    LinearCreditDebtTracker tracker;
    LinearCreditDebtTrackerInvariantHandler handler;

    function setUp() public {
        shares = createShares();
        owner = shares.owner();

        vm.prank(owner);
        shares.addAdmin(admin);

        tracker = LinearCreditDebtTracker(address(new LinearCreditDebtTrackerHarness({_shares: address(shares)})));

        handler = new LinearCreditDebtTrackerInvariantHandler(tracker, shares, admin);
        targetContract(address(handler));
    }

    function invariant_IndexMappingConsistency() public {
        // 1) ids[item.index] == item.id and index matches position in array
        uint24[] memory ids = tracker.getItemIds();
        for (uint256 i; i < ids.length; i++) {
            LinearCreditDebtTracker.Item memory item = tracker.getItem({ _id: ids[i] });
            assertEq(item.id, ids[i], "id mismatch for array entry");
            assertEq(item.index, i, "stored index mismatch");
            // implicit check: ids[item.index] == id via index equality above
        }

        // 2) uniqueness: no duplicates in ids array
        for (uint256 i; i < ids.length; i++) {
            for (uint256 j = i + 1; j < ids.length; j++) {
                assertTrue(ids[i] != ids[j], "duplicate id in ids array");
            }
        }

        // 3) mapping contains exactly the ids in the array (no extras)
        //    compare count of non-zero mapping entries in [1..lastId] to ids.length
        uint24 lastId = tracker.getLastItemId();
        uint256 mappingCount;
        for (uint24 id = 1; id <= lastId; id++) {
            if (tracker.getItem({_id: id}).id != 0) {
                mappingCount++;
            }
        }
        assertEq(mappingCount, ids.length, "mapping count should equal ids length");
    }
}

