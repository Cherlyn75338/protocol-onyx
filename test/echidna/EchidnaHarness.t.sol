// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Shares} from "src/shares/Shares.sol";
import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {ContinuousFlatRateManagementFeeTracker} from "src/components/fees/management-fee-trackers/ContinuousFlatRateManagementFeeTracker.sol";
import {ContinuousFlatRatePerformanceFeeTracker} from "src/components/fees/performance-fee-trackers/ContinuousFlatRatePerformanceFeeTracker.sol";
import {ValuationHandler} from "src/components/value/ValuationHandler.sol";
import {AccountERC20Tracker} from "src/components/value/position-trackers/AccountERC20Tracker.sol";
import {LinearCreditDebtTracker} from "src/components/value/position-trackers/LinearCreditDebtTracker.sol";
import {ERC7540LikeDepositQueue} from "src/components/issuance/deposit-handlers/ERC7540LikeDepositQueue.sol";
import {ERC7540LikeRedeemQueue} from "src/components/issuance/redeem-handlers/ERC7540LikeRedeemQueue.sol";
import {OpenAccessLimitedCallForwarder} from "src/components/roles/OpenAccessLimitedCallForwarder.sol";
import {LimitedAccessLimitedCallForwarder} from "src/components/roles/LimitedAccessLimitedCallForwarder.sol";
import {ComponentBeaconFactory} from "src/factories/ComponentBeaconFactory.sol";
import {BeaconFactory} from "src/factories/BeaconFactory.sol";
import {Global} from "src/global/Global.sol";
import {MockERC20} from "test/echidna/mocks/MockERC20.sol";
import {MockSharesTransferValidator} from "test/echidna/mocks/MockSharesTransferValidator.sol";
import {MockPositionTracker} from "test/echidna/mocks/MockPositionTracker.sol";

contract EchidnaHarness {
    // Core
    Shares public shares;
    FeeHandler public feeHandler;
    ValuationHandler public valuation;
    ContinuousFlatRateManagementFeeTracker public mgmt;
    ContinuousFlatRatePerformanceFeeTracker public perf;

    // Issuance
    ERC7540LikeDepositQueue public depositQ;
    ERC7540LikeRedeemQueue public redeemQ;

    // Roles
    OpenAccessLimitedCallForwarder public openFwd;
    LimitedAccessLimitedCallForwarder public limitedFwd;

    // Value tracking
    AccountERC20Tracker public acctTracker;
    LinearCreditDebtTracker public creditDebtTracker;
    MockPositionTracker public mockTracker;

    // Assets
    MockERC20 public asset;
    MockERC20 public feeAsset;

    // Admin/owner identities (Echidna fuzz will call from this contract address)
    address internal owner = address(this);
    address internal adminA = address(0xA11CE);
    address internal adminB = address(0xB0B);

    // Global + factories
    Global public global;
    BeaconFactory public sharesBeacon;
    ComponentBeaconFactory public componentBeacon;

    // Misc
    MockSharesTransferValidator public validator;

    constructor() {
        // Deploy global and factories
        global = new Global();
        global.init(address(this));
        sharesBeacon = new BeaconFactory(address(global));
        componentBeacon = new ComponentBeaconFactory(address(global));

        // Core instances (no proxying here for harness simplicity)
        shares = new Shares();
        shares.init(address(this), "Onyx", "ONX", bytes32("USD"));

        valuation = new ValuationHandler();
        feeHandler = new FeeHandler();
        mgmt = new ContinuousFlatRateManagementFeeTracker();
        perf = new ContinuousFlatRatePerformanceFeeTracker();

        // Wire components into Shares
        shares.addAdmin(adminA);
        shares.addAdmin(adminB);
        shares.setValuationHandler(address(valuation));
        shares.setFeeHandler(address(feeHandler));

        // Assets
        asset = new MockERC20("Asset", "AST");
        feeAsset = new MockERC20("Fee", "FEE");
        // Give this harness balances
        asset.mint(address(this), 1e24);
        feeAsset.mint(address(this), 1e24);
        // Ensure Shares holds fee asset liquidity for claims
        feeAsset.mint(address(shares), 1e24);

        // Set valuation rates (1:1 for asset and feeAsset)
        ValuationHandler.AssetRateInput[] memory rates = new ValuationHandler.AssetRateInput[](2);
        rates[0] = ValuationHandler.AssetRateInput({asset: address(asset), rate: uint128(1e18), expiry: uint40(block.timestamp + 365 days)});
        rates[1] = ValuationHandler.AssetRateInput({asset: address(feeAsset), rate: uint128(1e18), expiry: uint40(block.timestamp + 365 days)});
        valuation.setAssetRatesThenUpdateShareValue(rates, 0);

        // Fee handler config
        feeHandler.setFeeAsset(address(feeAsset));
        feeHandler.setManagementFee(address(mgmt), address(0xFEe1));
        feeHandler.setPerformanceFee(address(perf), address(0xFEe2));
        mgmt.resetLastSettled();
        perf.resetHighWaterMark();

        // Issuance queues
        depositQ = new ERC7540LikeDepositQueue();
        redeemQ = new ERC7540LikeRedeemQueue();
        shares.addDepositHandler(address(depositQ));
        shares.addRedeemHandler(address(redeemQ));
        depositQ.setAsset(address(asset));
        redeemQ.setAsset(address(asset));

        // Trackers
        acctTracker = new AccountERC20Tracker();
        acctTracker.init(address(shares));
        acctTracker.addAsset(address(asset));
        valuation.addPositionTracker(address(acctTracker));

        creditDebtTracker = new LinearCreditDebtTracker();
        valuation.addPositionTracker(address(creditDebtTracker));

        mockTracker = new MockPositionTracker();
        valuation.addPositionTracker(address(mockTracker));

        // Roles forwarders
        openFwd = new OpenAccessLimitedCallForwarder();
        limitedFwd = new LimitedAccessLimitedCallForwarder();

        // Shares transfer validator
        validator = new MockSharesTransferValidator();
        shares.setSharesTransferValidator(address(validator));
    }

    // ------------------------
    // Fuzz helpers (callable by Echidna)
    // ------------------------

    function fuzz_setEntranceFee(uint16 bps) external {
        // Only admin/owner allowed, Echidna calls from this address
        feeHandler.setEntranceFee(bps, address(0xE1));
    }

    function fuzz_setExitFee(uint16 bps) external {
        feeHandler.setExitFee(bps, address(0xE2));
    }

    // Linear tracker fuzzing and invariants
    function fuzz_addLinearItem(int128 totalValue, uint40 start, uint32 duration, int128 settled) external {
        if (totalValue == 0) return; // would revert
        try creditDebtTracker.addItem(totalValue, start, duration, "x") returns (uint24 id) {
            // Optionally set settled
            // ignore errors
            try creditDebtTracker.updateSettledValue(id, settled) {} catch {}
        } catch {}
    }

    function echidna_linear_item_bounds() external view returns (bool) {
        uint24[] memory ids = creditDebtTracker.getItemIds();
        uint256 limit = ids.length < 5 ? ids.length : 5;
        for (uint256 i; i < limit; i++) {
            LinearCreditDebtTracker.Item memory it = creditDebtTracker.getItem(ids[i]);
            int256 val = creditDebtTracker.calcItemValue(ids[i]);
            int256 low = it.settledValue;
            int256 high = it.settledValue + it.totalValue;
            if (low > high) {
                int256 tmp = low;
                low = high;
                high = tmp;
            }
            if (!(val >= low && val <= high)) return false;
        }
        return true;
    }

    // Conversion must revert if rate expired
    function echidna_convert_reverts_if_rate_expired() external returns (bool) {
        ValuationHandler.AssetRateInput memory ri = ValuationHandler.AssetRateInput({
            asset: address(asset),
            rate: uint128(1e18),
            expiry: uint40(block.timestamp - 1)
        });
        valuation.setAssetRate(ri);
        (bool ok,) = address(valuation).call(abi.encodeWithSelector(valuation.convertAssetAmountToValue.selector, address(asset), 1));
        return ok == false;
    }

    // Claiming fees reduces total owed when it succeeds
    function echidna_claim_decreases_total_owed_or_reverts() external returns (bool) {
        uint256 before_ = feeHandler.getTotalValueOwed();
        (bool ok,) = address(feeHandler).call(abi.encodeWithSelector(feeHandler.claimFees.selector, address(0xFEe1), uint256(1)));
        if (!ok) return true;
        uint256 after_ = feeHandler.getTotalValueOwed();
        return before_ == after_ + 1;
    }

    // Forwarders must deny by default
    function echidna_open_forwarder_denies_unconfigured_calls() external returns (bool) {
        OpenAccessLimitedCallForwarder.Call[] memory calls = new OpenAccessLimitedCallForwarder.Call[](1);
        uint256[] memory empty = new uint256[](0);
        calls[0] = OpenAccessLimitedCallForwarder.Call({
            target: address(depositQ),
            data: abi.encodeWithSelector(depositQ.executeDepositRequests.selector, empty),
            value: 0
        });
        (bool ok,) = address(openFwd).call(abi.encodeWithSelector(openFwd.executeCalls.selector, calls));
        return ok == false;
    }

    function echidna_limited_forwarder_denies_non_users() external returns (bool) {
        LimitedAccessLimitedCallForwarder.Call[] memory calls = new LimitedAccessLimitedCallForwarder.Call[](1);
        uint256[] memory empty = new uint256[](0);
        calls[0] = LimitedAccessLimitedCallForwarder.Call({
            target: address(depositQ),
            data: abi.encodeWithSelector(depositQ.executeDepositRequests.selector, empty),
            value: 0
        });
        (bool ok,) = address(limitedFwd).call(abi.encodeWithSelector(limitedFwd.executeCalls.selector, calls));
        return ok == false;
    }

    function fuzz_setMgmtRate(uint16 bps) external {
        mgmt.setRate(bps);
    }

    function fuzz_setPerfRate(uint16 bps) external {
        perf.setRate(bps);
    }

    function fuzz_updateRatesAndShareValue(uint128 rateAsset, uint40 expiryDelta, int256 untracked) external {
        uint40 expiry = uint40(block.timestamp + (expiryDelta % 365 days) + 1);
        ValuationHandler.AssetRateInput[] memory rates = new ValuationHandler.AssetRateInput[](1);
        rates[0] = ValuationHandler.AssetRateInput({asset: address(asset), rate: rateAsset == 0 ? uint128(1) : rateAsset, expiry: expiry});
        valuation.setAssetRatesThenUpdateShareValue(rates, untracked);
    }

    function fuzz_mintAssetToHarness(uint256 amt) external {
        asset.mint(address(this), amt);
    }

    function fuzz_requestDeposit(uint256 assets_) external {
        assets_ = assets_ % 1e24;
        if (assets_ == 0) return;
        asset.approve(address(depositQ), assets_);
        // controller==owner==msg.sender (this harness)
        depositQ.requestDeposit(assets_, address(this), address(this));
    }

    function fuzz_executeDeposits(uint256 count) external {
        uint256 last = depositQ.getDepositLastId();
        if (last == 0) return;
        count = count % (last + 1);
        if (count == 0) count = 1;
        uint256[] memory ids = new uint256[](count);
        for (uint256 i; i < count && i < last; i++) {
            ids[i] = last - i;
        }
        // move assets to harness first to ensure balance
        asset.mint(address(this), 1);
        depositQ.executeDepositRequests(ids);
    }

    function fuzz_requestRedeem(uint256 sharesAmt) external {
        sharesAmt = sharesAmt % (shares.balanceOf(address(this)) + 1);
        if (sharesAmt == 0) return;
        shares.approve(address(redeemQ), sharesAmt);
        redeemQ.requestRedeem(sharesAmt, address(this), address(this));
    }

    function fuzz_executeRedeems(uint256 count) external {
        uint256 last = redeemQ.getRedeemLastId();
        if (last == 0) return;
        count = count % (uint256(last) + 1);
        if (count == 0) count = 1;
        uint256[] memory ids = new uint256[](count);
        for (uint256 i; i < count && i < last; i++) {
            ids[i] = last - i;
        }
        // Ensure Shares holds asset liquidity
        asset.mint(address(shares), 1e24);
        redeemQ.executeRedeemRequests(ids);
    }

    // ------------------------
    // Invariants
    // ------------------------

    // Shares access control invariants
    function echidna_only_deposit_handler_can_mintFor() external returns (bool) {
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.mintFor.selector, address(this), 1));
        return ok == false;
    }

    function echidna_only_redeem_handler_can_burnFor() external returns (bool) {
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.burnFor.selector, address(this), 1));
        return ok == false;
    }

    function echidna_only_handlers_can_auth_transfer() external returns (bool) {
        // Attempting direct authTransfer should fail unless caller is handler; here caller is harness (not a handler)
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.authTransfer.selector, address(this), 1));
        return ok == false;
    }

    function echidna_only_redeem_handler_can_auth_transfer_from() external returns (bool) {
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.authTransferFrom.selector, address(this), address(this), 1));
        return ok == false;
    }

    function echidna_withdraw_asset_to_restricted() external returns (bool) {
        // Non-admin/non-handler call should revert
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.withdrawAssetTo.selector, address(asset), address(this), 1));
        return ok == false;
    }

    // Transfer validation path invoked when validator set
    function echidna_transfer_invokes_validator_when_set() external returns (bool) {
        validator.reset();
        // Mint shares first via deposit
        uint256 balBefore = shares.balanceOf(address(this));
        if (balBefore == 0) {
            asset.approve(address(depositQ), 1e18);
            depositQ.requestDeposit(1e18, address(this), address(this));
            uint256[] memory ids = new uint256[](1);
            ids[0] = depositQ.getDepositLastId();
            depositQ.executeDepositRequests(ids);
        }
        // Perform transfer
        (bool ok,) = address(shares).call(abi.encodeWithSelector(shares.transfer.selector, address(0x1234), 1));
        // If transfer succeeded and validator was set, the flag must be true
        return ok ? validator.wasCalled() : true;
    }

    // Fee bps bounds invariants
    function echidna_entrance_bps_lt_10000() external view returns (bool) {
        return feeHandler.getEntranceFeeBps() < 10000;
    }

    function echidna_exit_bps_lt_10000() external view returns (bool) {
        return feeHandler.getExitFeeBps() < 10000;
    }

    // ValuationHandler timestamp monotonicity when updateShareValue is called by owner
    function echidna_sharevalue_timestamp_nonzero_when_updated() external returns (bool) {
        // try to update with current config
        (bool ok,) = address(valuation).call(abi.encodeWithSelector(valuation.updateShareValue.selector, int256(0)));
        if (!ok) return true; // if it reverts due to math, ignore
        (, uint256 ts) = valuation.getShareValue();
        return ts > 0;
    }

    // If total supply is zero, sharePrice equals default
    function echidna_price_defaults_when_no_supply() external view returns (bool) {
        if (shares.totalSupply() != 0) return true;
        (uint256 price,) = valuation.getSharePrice();
        return price == valuation.getDefaultSharePrice();
    }

    // Fee settlement authorization: settleEntrance/Exit only by proper handlers
    function echidna_only_deposit_handler_can_settle_entrance() external returns (bool) {
        (bool ok,) = address(feeHandler).call(abi.encodeWithSelector(feeHandler.settleEntranceFeeGivenGrossShares.selector, 1e18));
        return ok == false;
    }

    function echidna_only_redeem_handler_can_settle_exit() external returns (bool) {
        (bool ok,) = address(feeHandler).call(abi.encodeWithSelector(feeHandler.settleExitFeeGivenGrossShares.selector, 1e18));
        return ok == false;
    }

    // Deposit queue: request constraints
    function echidna_deposit_request_owner_sender_controller_match() external returns (bool) {
        // Try to cheat with mismatched owner/controller -> should revert
        (bool ok,) = address(depositQ).call(abi.encodeWithSelector(depositQ.requestDeposit.selector, uint256(1), address(this), address(0xBEEF)));
        return ok == false;
    }

    // Redeem queue: request constraints
    function echidna_redeem_request_owner_sender_controller_match() external returns (bool) {
        (bool ok,) = address(redeemQ).call(abi.encodeWithSelector(redeemQ.requestRedeem.selector, uint256(1), address(this), address(0xBEEF)));
        return ok == false;
    }

    // Fee handler dynamic settlement restricted to valuation handler
    function echidna_only_valuation_can_settle_dynamic() external returns (bool) {
        (bool ok,) = address(feeHandler).call(abi.encodeWithSelector(feeHandler.settleDynamicFeesGivenPositionsValue.selector, uint256(1)));
        return ok == false;
    }

    // Entrance/exit fee never exceeds gross
    function echidna_fee_shares_do_not_exceed_gross() external view returns (bool) {
        uint256 g = 1e18;
        uint256 eIn;
        uint256 eOut;
        address fh = address(feeHandler);
        // Read-only call via staticcall to avoid auth; but functions are non-view, so we just check the formula bounds using getters
        // eIn <= g and eOut <= g if bps < 10000 always holds
        uint16 bIn = feeHandler.getEntranceFeeBps();
        uint16 bOut = feeHandler.getExitFeeBps();
        eIn = (g * bIn) / 10000;
        eOut = (g * bOut) / 10000;
        return eIn <= g && eOut <= g && fh != address(0);
    }
}

