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

import {ERC7540LikeDepositQueue} from "src/components/issuance/deposit-handlers/ERC7540LikeDepositQueue.sol";
import {ERC7540LikeRedeemQueue} from "src/components/issuance/redeem-handlers/ERC7540LikeRedeemQueue.sol";
import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {ValuationHandler} from "src/components/value/ValuationHandler.sol";
import {Shares} from "src/shares/Shares.sol";
import {SHARES_PRECISION} from "src/utils/Constants.sol";

import {ERC7540LikeDepositQueueHarness} from "test/harnesses/ERC7540LikeDepositQueueHarness.sol";
import {ERC7540LikeRedeemQueueHarness} from "test/harnesses/ERC7540LikeRedeemQueueHarness.sol";
import {FeeHandlerHarness} from "test/harnesses/FeeHandlerHarness.sol";
import {ValuationHandlerHarness} from "test/harnesses/ValuationHandlerHarness.sol";
import {MockERC20} from "test/mocks/MockERC20.sol";
import {AccountERC20Tracker} from "src/components/value/position-trackers/AccountERC20Tracker.sol";
import {AccountERC20TrackerHarness} from "test/harnesses/AccountERC20TrackerHarness.sol";
import {TestHelpers} from "test/utils/TestHelpers.sol";

contract EconomicAttacksTest is Test, TestHelpers {
    Shares internal shares;
    address internal owner;
    address internal admin = makeAddr("admin");

    function setUp() public {
        shares = createShares();
        owner = shares.owner();

        vm.prank(owner);
        shares.addAdmin(admin);
    }

    //==================================================================================================================
    // 1) Stale price deposit over-mint then redeem profit
    //==================================================================================================================

    function test_staleDeposit_overmint_thenRedeemProfit() public {
        // Deploy handlers
        ERC7540LikeDepositQueueHarness depositQueue = new ERC7540LikeDepositQueueHarness(address(shares));
        ERC7540LikeRedeemQueueHarness redeemQueue = new ERC7540LikeRedeemQueueHarness(address(shares));
        vm.startPrank(admin);
        shares.addDepositHandler(address(depositQueue));
        shares.addRedeemHandler(address(redeemQueue));
        vm.stopPrank();

        // Deploy valuation handler and tracker (track Shares' ERC20 holdings)
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        uint8 assetDecimals = 6;
        MockERC20 asset = new MockERC20(assetDecimals);
        vm.startPrank(admin);
        depositQueue.setAsset(address(asset));
        redeemQueue.setAsset(address(asset));
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(asset), rate: uint128(1e18), expiry: uint40(block.timestamp + 1 days)})
        );
        // Add an ERC20 tracker for Shares' holdings
        AccountERC20Tracker tracker = AccountERC20Tracker(address(new AccountERC20TrackerHarness(address(shares))));
        tracker.init(address(shares));
        tracker.addAsset(address(asset));
        valuationHandler.addPositionTracker(address(tracker));
        vm.stopPrank();

        // Initial LP deposits at fresh price (p_old = 1.0)
        address lp = makeAddr("lp");
        uint256 lpAssets = 1_000_000; // 1.0 asset
        asset.mintTo(lp, lpAssets);
        vm.startPrank(lp);
        asset.approve(address(depositQueue), type(uint256).max);
        uint256 lpReq = depositQueue.requestDeposit({_assets: lpAssets, _controller: lp, _owner: lp});
        vm.stopPrank();
        vm.prank(admin);
        depositQueue.executeDepositRequests(_asArray(lpReq));

        // Freshly update share value at p_old = 1.0 (tracked positions only)
        vm.prank(admin);
        valuationHandler.updateShareValue(0);

        emit log_named_uint("p_old (share value)", _getShareValue(address(valuationHandler)));
        emit log_named_uint("supply after LP deposit", shares.totalSupply());
        emit log_named_uint("Shares asset balance after LP", IERC20(address(asset)).balanceOf(address(shares)));

        // Off-chain PnL doubles net asset value, but admin does NOT update share value (stale = 1.0)
        // Attacker deposits while price is stale. We'll keep asset rate constant and realize PnL via untracked later.
        address attacker = makeAddr("attacker");
        uint256 attackerAssets = 1_000_000; // 1.0 asset
        asset.mintTo(attacker, attackerAssets);
        vm.startPrank(attacker);
        asset.approve(address(depositQueue), type(uint256).max);
        uint256 attackerReq = depositQueue.requestDeposit({_assets: attackerAssets, _controller: attacker, _owner: attacker});
        vm.stopPrank();

        // Execute attacker deposit at stale p_old = 1.0
        uint256 supplyBeforeAttacker = shares.totalSupply();
        vm.prank(admin);
        depositQueue.executeDepositRequests(_asArray(attackerReq));
        uint256 attackerShares = shares.balanceOf(attacker);

        emit log_named_uint("attacker minted shares (stale)", attackerShares);
        emit log_named_uint("supply after attacker deposit", shares.totalSupply());

        // Now admin updates share value to p_true = 2.0 using untrackedPositionsValue
        // tracked value = (lpAssets + attackerAssets) in value units (rate = 1e18) = 2e18
        // total supply after attacker deposit = 2e18 (1.0 + 1.0)
        // To set p_true = 2e18: totalPositionsValue must be p_true * supply / 1e18 = 2e18 * 2e18 / 1e18 = 4e18
        // So untrackedPositionsValue = 4e18 - tracked(2e18) = 2e18
        uint256 untrackedToTwoX = 2e18;
        vm.prank(admin);
        valuationHandler.updateShareValue(int256(untrackedToTwoX));
        emit log_named_uint("p_true (updated share value)", _getShareValue(address(valuationHandler)));

        // Attacker redeems all their shares
        vm.startPrank(attacker);
        shares.approve(address(redeemQueue), type(uint256).max);
        uint256 redeemId = redeemQueue.requestRedeem({_shares: attackerShares, _controller: attacker, _owner: attacker});
        vm.stopPrank();

        uint256 attackerAssetBefore = IERC20(address(asset)).balanceOf(attacker);
        uint256 sharesAssetBefore = IERC20(address(asset)).balanceOf(address(shares));
        emit log_named_uint("attacker asset before redeem", attackerAssetBefore);
        emit log_named_uint("Shares asset balance before redeem", sharesAssetBefore);

        vm.prank(admin);
        redeemQueue.executeRedeemRequests(_asArray(redeemId));

        uint256 attackerAssetAfter = IERC20(address(asset)).balanceOf(attacker);
        uint256 sharesAssetAfter = IERC20(address(asset)).balanceOf(address(shares));
        emit log_named_uint("attacker asset after redeem", attackerAssetAfter);
        emit log_named_uint("Shares asset balance after redeem", sharesAssetAfter);

        // Attacker drained the pool beyond their contribution (profit = attackerAssets)
        assertEq(attackerAssetAfter - attackerAssetBefore, attackerAssets * 2); // received 2.0 assets
        assertEq(sharesAssetAfter, 0);
    }

    //==================================================================================================================
    // 2) Stale price redemption over-payout
    //==================================================================================================================

    function test_staleRedeem_overpayout() public {
        // Deploy handlers
        ERC7540LikeDepositQueueHarness depositQueue = new ERC7540LikeDepositQueueHarness(address(shares));
        ERC7540LikeRedeemQueueHarness redeemQueue = new ERC7540LikeRedeemQueueHarness(address(shares));
        vm.startPrank(admin);
        shares.addDepositHandler(address(depositQueue));
        shares.addRedeemHandler(address(redeemQueue));
        vm.stopPrank();

        // Deploy valuation handler and tracker
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        uint8 assetDecimals = 6;
        MockERC20 asset = new MockERC20(assetDecimals);
        vm.startPrank(admin);
        depositQueue.setAsset(address(asset));
        redeemQueue.setAsset(address(asset));
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(asset), rate: uint128(1e18), expiry: uint40(block.timestamp + 1 days)})
        );
        AccountERC20Tracker tracker = AccountERC20Tracker(address(new AccountERC20TrackerHarness(address(shares))));
        tracker.init(address(shares));
        tracker.addAsset(address(asset));
        valuationHandler.addPositionTracker(address(tracker));
        vm.stopPrank();

        // Initial LP deposit (creates supply and funds pool)
        address lp = makeAddr("lp:redeem");
        uint256 lpAssets = 1_000_000; // 1.0 asset
        asset.mintTo(lp, lpAssets);
        vm.startPrank(lp);
        asset.approve(address(depositQueue), type(uint256).max);
        uint256 lpReq = depositQueue.requestDeposit({_assets: lpAssets, _controller: lp, _owner: lp});
        vm.stopPrank();
        vm.prank(admin);
        depositQueue.executeDepositRequests(_asArray(lpReq));

        // Fresh share value at 1.0
        vm.prank(admin);
        valuationHandler.updateShareValue(0);
        emit log_named_uint("fresh share value", _getShareValue(address(valuationHandler)));

        // Admin previously updated share value to a high stale value via untracked (e.g., 3.0)
        // total supply S0 = value/1e18 = 1e18; tracked=1e18; need totalPositions=3e18 => untracked=2e18
        vm.prank(admin);
        valuationHandler.updateShareValue(int256(2e18));
        emit log_named_uint("stale-high share value (stored)", _getShareValue(address(valuationHandler)));

        // Attacker holds a fraction of supply (20%) by acquiring shares beforehand (via test deal for simplicity)
        address attacker = makeAddr("attacker:redeem");
        uint256 sharesAmount = shares.totalSupply() / 5; // 20%
        deal(address(shares), attacker, sharesAmount, true);

        // Redeem using stale-high share value (3.0)
        vm.startPrank(attacker);
        shares.approve(address(redeemQueue), type(uint256).max);
        uint256 reqId = redeemQueue.requestRedeem({_shares: sharesAmount, _controller: attacker, _owner: attacker});
        vm.stopPrank();

        uint256 attackerAssetBefore = IERC20(address(asset)).balanceOf(attacker);
        uint256 sharesAssetBefore = IERC20(address(asset)).balanceOf(address(shares));
        emit log_named_uint("attacker asset before redeem", attackerAssetBefore);
        emit log_named_uint("Shares asset balance before redeem", sharesAssetBefore);

        vm.prank(admin);
        redeemQueue.executeRedeemRequests(_asArray(reqId));

        uint256 attackerAssetAfter = IERC20(address(asset)).balanceOf(attacker);
        uint256 sharesAssetAfter = IERC20(address(asset)).balanceOf(address(shares));
        emit log_named_uint("attacker asset after redeem", attackerAssetAfter);
        emit log_named_uint("Shares asset balance after redeem", sharesAssetAfter);

        // With stale 3.0 share value and 1.0 rate, 20% redemption extracts 60% of pool assets
        assertEq(attackerAssetAfter - attackerAssetBefore, (lpAssets * 3) / 5);
        assertEq(sharesAssetAfter, lpAssets - ((lpAssets * 3) / 5));
    }

    //==================================================================================================================
    // 3) Fee mispricing with default share price when share value == 0 and supply > 0
    //==================================================================================================================

    function test_feeDefaultPrice_whenShareValueZero_supplyPositive() public {
        // Deploy fee handler
        FeeHandlerHarness feeHandler = new FeeHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setFeeHandler(address(feeHandler));

        // Deploy valuation handler and set lastShareValue == 0 (forces default price in getSharePrice)
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        valuationHandler.harness_setLastShareValue({_shareValue: 0, _timestamp: block.timestamp});

        // Ensure supply > 0
        increaseSharesSupply(address(shares), 1e18);

        // Configure entrance fee
        uint16 feeBps = 500; // 5%
        address feeRecipient = makeAddr("feeRecipient:defaultPrice");
        vm.prank(admin);
        feeHandler.setEntranceFee({_feeBps: feeBps, _recipient: feeRecipient});

        // Allow a caller as deposit handler to settle entrance fee
        address settleCaller = makeAddr("settleCaller:defaultPrice");
        vm.prank(admin);
        shares.addDepositHandler(settleCaller);

        // Settle entrance fee on a gross shares amount
        uint256 grossSharesAmount = 10_000 * 1e18;
        uint256 expectedFeeShares = grossSharesAmount * feeBps / 10_000;
        // With default share price = 1e18, expected value owed equals expectedFeeShares
        uint256 expectedFeeValue = expectedFeeShares; // 1:1 at default price

        vm.prank(settleCaller);
        uint256 feeSharesAmount = feeHandler.settleEntranceFeeGivenGrossShares({_grossSharesAmount: grossSharesAmount});
        assertEq(feeSharesAmount, expectedFeeShares);
        assertEq(feeHandler.getTotalValueOwed(), expectedFeeValue);
        assertEq(feeHandler.getValueOwedToUser(feeRecipient), expectedFeeValue);
    }

    //==================================================================================================================
    // 4) Fee asset switch after accrual influences payout token amounts
    //==================================================================================================================

    function test_feeAssetSwitch_affectsClaimPayout() public {
        // Deploy fee handler
        FeeHandlerHarness feeHandler = new FeeHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setFeeHandler(address(feeHandler));

        // Deploy valuation handler
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        // Two fee assets with different rates
        MockERC20 tokenA = new MockERC20(6); // 6 decimals
        MockERC20 tokenB = new MockERC20(6); // 6 decimals
        vm.startPrank(admin);
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(tokenA), rate: uint128(1e18), expiry: uint40(block.timestamp + 1 days)})
        );
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(tokenB), rate: uint128(2e18), expiry: uint40(block.timestamp + 1 days)})
        );
        vm.stopPrank();

        // Accrue value owed to recipient
        address recipient = makeAddr("recipient:feeAssetSwitch");
        uint256 valueToClaim = 10e18; // value in share value asset
        vm.prank(address(feeHandler));
        feeHandler.exposed_increaseValueOwed({_user: recipient, _delta: valueToClaim});

        // Case A: claim in tokenA
        vm.prank(admin);
        feeHandler.setFeeAsset(address(tokenA));
        // Ensure Shares has enough tokenA liquidity
        uint256 expectedTokenAAmount = _convertValueToAssetAmount({value_: valueToClaim, rate_: 1e18, quoteDecimals_: 6});
        tokenA.mintTo(address(shares), expectedTokenAAmount);

        vm.prank(admin);
        uint256 claimedA = feeHandler.claimFees({_onBehalf: recipient, _value: valueToClaim});
        assertEq(claimedA, expectedTokenAAmount);
        assertEq(IERC20(address(tokenA)).balanceOf(recipient), expectedTokenAAmount);

        // Re-accrue same value to claim in tokenB
        vm.prank(address(feeHandler));
        feeHandler.exposed_increaseValueOwed({_user: recipient, _delta: valueToClaim});

        vm.prank(admin);
        feeHandler.setFeeAsset(address(tokenB));
        uint256 expectedTokenBAmount = _convertValueToAssetAmount({value_: valueToClaim, rate_: 2e18, quoteDecimals_: 6});
        tokenB.mintTo(address(shares), expectedTokenBAmount);

        vm.prank(admin);
        uint256 claimedB = feeHandler.claimFees({_onBehalf: recipient, _value: valueToClaim});
        assertEq(claimedB, expectedTokenBAmount);
        assertEq(IERC20(address(tokenB)).balanceOf(recipient), expectedTokenBAmount);

        // Verify different payout amounts across assets/rates
        assertGt(claimedA, claimedB); // because tokenB rate is higher (2x), amount is smaller
    }

    //==================================================================================================================
    // Helpers
    //==================================================================================================================

    function _asArray(uint256 x) internal pure returns (uint256[] memory a_) {
        a_ = new uint256[](1);
        a_[0] = x;
    }

    function _convertValueToAssetAmount(uint256 value_, uint256 rate_, uint8 quoteDecimals_) internal pure returns (uint256) {
        // Mirrors ValueHelpersLib.convert with _rateQuotedInBase == true
        // quoteAmount = (value * ratePrecision * quotePrecision) / (rate * basePrecision)
        uint256 ratePrecision = 1e18;
        uint256 quotePrecision = 10 ** quoteDecimals_;
        uint256 basePrecision = 1e18;
        return (value_ * ratePrecision * quotePrecision) / (rate_ * basePrecision);
    }

    function _getShareValue(address valuationHandler_) internal view returns (uint256) {
        (uint256 v,) = ValuationHandler(valuationHandler_).getShareValue();
        return v;
    }
}

