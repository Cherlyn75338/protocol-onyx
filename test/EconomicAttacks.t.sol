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

        // Deploy valuation handler
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        // Set asset and rate
        uint8 assetDecimals = 6;
        MockERC20 asset = new MockERC20(assetDecimals);
        vm.startPrank(admin);
        depositQueue.setAsset(address(asset));
        redeemQueue.setAsset(address(asset));
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(asset), rate: uint128(1e18), expiry: uint40(block.timestamp + 1 days)})
        );
        vm.stopPrank();

        // Set stale share value (old)
        uint256 pOld = 1e18; // 1.0
        valuationHandler.harness_setLastShareValue({
            _shareValue: pOld,
            _timestamp: 1
        });

        // Controller deposits 1 unit of asset (1e6 units given 6 decimals)
        address controller = makeAddr("controller:staleDeposit");
        uint256 depositAssets = 1_000_000; // 1.0 asset
        asset.mintTo(controller, depositAssets);
        vm.prank(controller);
        asset.approve(address(depositQueue), type(uint256).max);

        vm.prank(controller);
        uint256 requestId = depositQueue.requestDeposit({
            _assets: depositAssets,
            _controller: controller,
            _owner: controller
        });

        // Execute deposit at stale price
        uint256 preExecuteSharesSupply = shares.totalSupply();
        vm.prank(admin);
        depositQueue.executeDepositRequests({_requestIds: _asArray(requestId)});

        // Minted shares = value / pOld = (assets * 1e12) / pOld, scaled by SHARES_PRECISION
        // Using library: calcSharesAmountForValue = SHARES_PRECISION * value / valuePerShare
        uint256 controllerShares = shares.balanceOf(controller);
        assertGt(controllerShares, 0);
        assertEq(shares.totalSupply(), preExecuteSharesSupply + controllerShares);

        // Update to a higher true price and pre-seed extra assets required to honor redemption
        uint256 pTrue = 2e18; // 2.0
        valuationHandler.harness_setLastShareValue({_shareValue: pTrue, _timestamp: block.timestamp});

        // Expected redeemed assets at pTrue: depositAssets * (pTrue / pOld) = 2x
        uint256 expectedRedeemAssets = depositAssets * pTrue / pOld;
        // Seed Shares with the additional amount required beyond the deposit
        uint256 extra = expectedRedeemAssets - depositAssets;
        asset.mintTo(address(shares), extra);

        // Request redeem of all shares and execute
        vm.prank(controller);
        shares.approve(address(redeemQueue), type(uint256).max);

        vm.prank(controller);
        uint256 redeemId = redeemQueue.requestRedeem({
            _shares: controllerShares,
            _controller: controller,
            _owner: controller
        });

        vm.prank(admin);
        redeemQueue.executeRedeemRequests({_requestIds: _asArray(redeemId)});

        // Profit should be depositAssets (2x payout)
        assertEq(IERC20(address(asset)).balanceOf(controller), expectedRedeemAssets);
        assertEq(IERC20(address(asset)).balanceOf(address(shares)), 0);
    }

    //==================================================================================================================
    // 2) Stale price redemption over-payout
    //==================================================================================================================

    function test_staleRedeem_overpayout() public {
        // Deploy handlers
        ERC7540LikeRedeemQueueHarness redeemQueue = new ERC7540LikeRedeemQueueHarness(address(shares));
        vm.prank(admin);
        shares.addRedeemHandler(address(redeemQueue));

        // Deploy valuation handler
        ValuationHandlerHarness valuationHandler = new ValuationHandlerHarness(address(shares));
        vm.prank(admin);
        shares.setValuationHandler(address(valuationHandler));

        // Set asset and rate
        uint8 assetDecimals = 6;
        MockERC20 asset = new MockERC20(assetDecimals);
        vm.prank(admin);
        redeemQueue.setAsset(address(asset));
        vm.prank(admin);
        valuationHandler.setAssetRate(
            ValuationHandler.AssetRateInput({asset: address(asset), rate: uint128(1e18), expiry: uint40(block.timestamp + 1 days)})
        );

        // Set stale-high price
        uint256 pOld = 3e18; // 3.0 (stale high)
        valuationHandler.harness_setLastShareValue({_shareValue: pOld, _timestamp: 1});

        // Seed user shares (bypassing issuance for simplicity) and seed Shares with assets to pay out
        address controller = makeAddr("controller:staleRedeem");
        uint256 sharesAmount = 1e18; // 1.0 share
        deal(address(shares), controller, sharesAmount, true);

        // Expected assets using stale-high price: value = shares * pOld / 1e18; assets = value * 1e6 / 1e18
        uint256 expectedAssets = (sharesAmount * pOld / SHARES_PRECISION) * (10 ** assetDecimals) / 1e18;
        // Seed Shares with the required assets
        asset.mintTo(address(shares), expectedAssets);

        // Request and execute redeem
        vm.prank(controller);
        shares.approve(address(redeemQueue), type(uint256).max);

        vm.prank(controller);
        uint256 requestId = redeemQueue.requestRedeem({_shares: sharesAmount, _controller: controller, _owner: controller});

        vm.prank(admin);
        redeemQueue.executeRedeemRequests({_requestIds: _asArray(requestId)});

        // User receives assets computed from stale-high price
        assertEq(IERC20(address(asset)).balanceOf(controller), expectedAssets);
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
}

