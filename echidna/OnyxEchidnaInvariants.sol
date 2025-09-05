// SPDX-License-Identifier: BUSL-1.1

/*
    This file is part of the Onyx Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.28;

import {Shares} from "src/shares/Shares.sol";
import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {ContinuousFlatRateManagementFeeTracker} from "src/components/fees/management-fee-trackers/ContinuousFlatRateManagementFeeTracker.sol";
import {ContinuousFlatRatePerformanceFeeTracker} from "src/components/fees/performance-fee-trackers/ContinuousFlatRatePerformanceFeeTracker.sol";
import {ValuationHandler} from "src/components/value/ValuationHandler.sol";
import {ERC7540LikeDepositQueue} from "src/components/issuance/deposit-handlers/ERC7540LikeDepositQueue.sol";
import {ERC7540LikeRedeemQueue} from "src/components/issuance/redeem-handlers/ERC7540LikeRedeemQueue.sol";
import {ComponentBeaconFactory} from "src/factories/ComponentBeaconFactory.sol";
import {Global} from "src/global/Global.sol";

/// @notice Minimal ERC20 implementation for testing as deposit/redeem asset
contract MockERC20 {
    string public name;
    string public symbol;
    uint8 public immutable decimals;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function mint(address _to, uint256 _amount) external {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    function approve(address _spender, uint256 _amount) external returns (bool) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transfer(address _to, uint256 _amount) external returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool) {
        uint256 allowed = allowance[_from][msg.sender];
        require(allowed >= _amount, "ALLOWANCE");
        allowance[_from][msg.sender] = allowed - _amount;
        _transfer(_from, _to, _amount);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(balanceOf[_from] >= _amount, "BALANCE");
        unchecked {
            balanceOf[_from] -= _amount;
            balanceOf[_to] += _amount;
        }
        emit Transfer(_from, _to, _amount);
    }
}

/// @notice Helper to attempt unauthorized calls; returns success = true if call did NOT revert
contract Attacker {
    function attempt(address _target, bytes memory _data) public returns (bool success_) {
        (success_,) = _target.call(_data);
    }
}

/// @title OnyxEchidnaInvariants
/// @notice Echidna harness deploying Shares + components behind ComponentBeaconProxy
contract OnyxEchidnaInvariants {
    // Core
    Shares public shares;
    ValuationHandler public valuation;
    FeeHandler public feeHandler;

    // Fees
    ContinuousFlatRateManagementFeeTracker public mgmtFee;
    ContinuousFlatRatePerformanceFeeTracker public perfFee;

    // Issuance
    ERC7540LikeDepositQueue public depositQueue;
    ERC7540LikeRedeemQueue public redeemQueue;

    // Asset
    MockERC20 public asset;

    // Infra
    Global public global;
    ComponentBeaconFactory public beacon;
    Attacker public attacker;

    // Constants
    uint128 internal constant ONE = 1e18;

    constructor() {
        // Deploy Shares
        shares = new Shares();
        shares.init(address(this), "Onyx Shares", "SHR", bytes32("USD"));

        // Deploy Global + Beacon
        global = new Global();
        global.init(address(this));
        beacon = new ComponentBeaconFactory(address(global));

        // Deploy components behind proxies via beacon
        valuation = ValuationHandler(_deployComponent(address(new ValuationHandler())));
        feeHandler = FeeHandler(_deployComponent(address(new FeeHandler())));
        depositQueue = ERC7540LikeDepositQueue(_deployComponent(address(new ERC7540LikeDepositQueue())));
        redeemQueue = ERC7540LikeRedeemQueue(_deployComponent(address(new ERC7540LikeRedeemQueue())));
        mgmtFee = ContinuousFlatRateManagementFeeTracker(
            _deployComponent(address(new ContinuousFlatRateManagementFeeTracker()))
        );
        perfFee = ContinuousFlatRatePerformanceFeeTracker(
            _deployComponent(address(new ContinuousFlatRatePerformanceFeeTracker()))
        );

        // Wire Shares <-> components
        shares.setValuationHandler(address(valuation));
        shares.setFeeHandler(address(feeHandler));
        shares.addDepositHandler(address(depositQueue));
        shares.addRedeemHandler(address(redeemQueue));

        // Configure issuance asset
        asset = new MockERC20("Mock USD", "mUSD", 18);
        depositQueue.setAsset(address(asset));
        redeemQueue.setAsset(address(asset));

        // Configure valuation: 1:1 rate with long expiry
        ValuationHandler.AssetRateInput memory inp = ValuationHandler.AssetRateInput({
            asset: address(asset),
            rate: ONE,
            expiry: uint40(block.timestamp + 365 days)
        });
        valuation.setAssetRate(inp);

        // Configure fees: set recipients to this harness address
        feeHandler.setFeeAsset(address(asset));
        feeHandler.setManagementFee(address(mgmtFee), address(this));
        feeHandler.setPerformanceFee(address(perfFee), address(this));
        feeHandler.setEntranceFee(0, address(this));
        feeHandler.setExitFee(0, address(this));

        // Initialize trackers
        mgmtFee.resetLastSettled();
        perfFee.resetHighWaterMark();

        attacker = new Attacker();
    }

    function _deployComponent(address _implementation) internal returns (address proxy_) {
        beacon.setImplementation(_implementation);
        proxy_ = beacon.deployProxy(address(shares), bytes(""));
    }

    //====================================
    // Helper admin fuzz functions (state)
    //====================================

    function admin_setAssetRate(uint128 _rate, uint40 _ttl) public {
        uint128 rate = _rate == 0 ? ONE : _rate; // avoid zero
        uint40 expiry = uint40(block.timestamp + (_ttl % (365 days)) + 1);
        valuation.setAssetRate(ValuationHandler.AssetRateInput({asset: address(asset), rate: rate, expiry: expiry}));
    }

    function admin_updateShareValue(int256 _untracked) public {
        // Allow any value; ValuationHandler will revert if invalid (fine for fuzz)
        valuation.updateShareValue(_untracked);
    }

    function admin_setEntranceFee(uint16 _bps) public {
        // clamp to < 10_000
        uint16 bps = uint16(uint256(_bps) % 10_000);
        feeHandler.setEntranceFee(bps, address(this));
    }

    function admin_setExitFee(uint16 _bps) public {
        uint16 bps = uint16(uint256(_bps) % 10_000);
        feeHandler.setExitFee(bps, address(this));
    }

    function admin_claimFees(uint256 _value) public {
        feeHandler.claimFees(address(this), _value);
    }

    //====================================
    // User fuzz helpers (state)
    //====================================

    function user_faucet_and_requestDeposit(uint256 _assets) public {
        uint256 amt = _assets % (10 ** 30);
        if (amt == 0) return;
        asset.mint(msg.sender, amt);
        // Approve and request deposit (owner=controller=msg.sender)
        require(asset.approve(address(depositQueue), amt));
        depositQueue.requestDeposit(amt, msg.sender, msg.sender);
    }

    function admin_executeDeposit(uint256 _requestId) public {
        uint256[] memory ids = new uint256[](1);
        ids[0] = _requestId;
        depositQueue.executeDepositRequests(ids);
    }

    function user_requestRedeem(uint256 _sharesAmount) public {
        uint256 amt = _sharesAmount % (10 ** 30);
        if (amt == 0) return;
        redeemQueue.requestRedeem(amt, msg.sender, msg.sender);
    }

    function admin_executeRedeem(uint256 _requestId) public {
        uint256[] memory ids = new uint256[](1);
        ids[0] = _requestId;
        redeemQueue.executeRedeemRequests(ids);
    }

    //====================================
    // Invariants (properties)
    //====================================

    // Access control: Shares.mintFor only deposit handler
    function echidna_only_deposit_handler_can_mint() public returns (bool) {
        bool ok = attacker.attempt(
            address(shares), abi.encodeWithSignature("mintFor(address,uint256)", address(this), uint256(1))
        );
        return !ok;
    }

    // Access control: Shares.authTransferFrom only redeem handler
    function echidna_only_redeem_handler_can_auth_transfer_from() public returns (bool) {
        bool ok = attacker.attempt(
            address(shares), abi.encodeWithSignature("authTransferFrom(address,address,uint256)", address(this), address(0), uint256(1))
        );
        return !ok;
    }

    // Access control: FeeHandler.settleDynamicFeesGivenPositionsValue only valuation handler
    function echidna_only_valuation_can_settle_dynamic_fees() public returns (bool) {
        bool ok = attacker.attempt(
            address(feeHandler), abi.encodeWithSignature("settleDynamicFeesGivenPositionsValue(uint256)", uint256(1))
        );
        return !ok;
    }

    // Access control: FeeHandler.settleEntranceFeeGivenGrossShares only deposit handler
    function echidna_only_deposit_handler_can_settle_entrance_fee() public returns (bool) {
        bool ok = attacker.attempt(
            address(feeHandler), abi.encodeWithSignature("settleEntranceFeeGivenGrossShares(uint256)", uint256(1))
        );
        return !ok;
    }

    // Access control: FeeHandler.settleExitFeeGivenGrossShares only redeem handler
    function echidna_only_redeem_handler_can_settle_exit_fee() public returns (bool) {
        bool ok = attacker.attempt(
            address(feeHandler), abi.encodeWithSignature("settleExitFeeGivenGrossShares(uint256)", uint256(1))
        );
        return !ok;
    }

    // Access control: Shares.withdrawAssetTo only admin/redeem/fee handler
    function echidna_withdraw_asset_to_is_restricted() public returns (bool) {
        bool ok = attacker.attempt(
            address(shares), abi.encodeWithSignature("withdrawAssetTo(address,address,uint256)", address(asset), address(this), uint256(1))
        );
        return !ok;
    }

    // Accounting: all fees owed are tracked to the harness recipient (we set all fee recipients to this)
    function echidna_fee_total_equals_recipient_owed() public view returns (bool) {
        uint256 total = feeHandler.getTotalValueOwed();
        uint256 owed = feeHandler.getValueOwedToUser(address(this));
        return total == owed;
    }

    // Valuation conversions: 1:1 mapping for asset with 18 decimals at rate 1e18
    function echidna_identity_conversion(uint256 _amt) public view returns (bool) {
        uint256 amt = _amt % (10 ** 30);
        (uint256 price,) = shares.sharePrice();
        // price must always be > 0 per contract defaults
        bool priceOk = price > 0;
        uint256 v = valuation.convertAssetAmountToValue(address(asset), amt);
        uint256 a = valuation.convertValueToAssetAmount(amt, address(asset));
        return priceOk && v == amt && a == amt;
    }
}

