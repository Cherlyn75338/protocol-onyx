// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {FeeHandler} from "src/components/fees/FeeHandler.sol";
import {MockERC20} from "test/echidna/mocks/MockERC20.sol";
import {MockShares} from "test/echidna/mocks/MockShares.sol";
import {MockValuationHandler} from "test/echidna/mocks/MockValuationHandler.sol";
import {ONE_HUNDRED_PERCENT_BPS} from "src/utils/Constants.sol";

contract EchidnaFeeHandler is FeeHandler {
    MockShares public sharesMock;
    MockValuationHandler public valMock;
    MockERC20 public feeAsset;

    constructor() payable {
        // deploy mocks
        feeAsset = new MockERC20("FEE","FEE",18);
        sharesMock = new MockShares(address(feeAsset));
        valMock = new MockValuationHandler();
        valMock.setAsset(address(feeAsset), 18, 1e18);

        // wire into FeeHandler via ComponentHelpersMixin
        sharesMock.addAdmin(address(this));
        sharesMock.setFeeHandler(address(this));
        sharesMock.setValuationHandler(address(valMock));

        // set fee asset
        this.setFeeAsset(address(feeAsset));
        // set recipients
        this.setManagementFee(address(0), address(this));
        this.setPerformanceFee(address(0), address(this));
        // default zero entrance/exit
        this.setEntranceFee(0, address(this));
        this.setExitFee(0, address(this));
    }

    // Helpers to route ComponentHelpersMixin to mock shares
    function SHARES() external view returns (address) { return address(sharesMock); }

    // Properties
    function set_entrance_fee_bps(uint16 bps) external {
        if (bps >= ONE_HUNDRED_PERCENT_BPS) return;
        this.setEntranceFee(bps, address(this));
    }

    function set_exit_fee_bps(uint16 bps) external {
        if (bps >= ONE_HUNDRED_PERCENT_BPS) return;
        this.setExitFee(bps, address(this));
    }

    // Assert fee shares = floor(gross * bps / 10000)
    function prop_entrance_exit_fee_math(uint256 gross, uint16 bps) external {
        if (bps >= ONE_HUNDRED_PERCENT_BPS) return;
        uint256 expected = (gross * bps) / ONE_HUNDRED_PERCENT_BPS;
        this.set_entrance_fee_bps(bps);
        uint256 gotIn = this.settleEntranceFeeGivenGrossShares(gross);
        assert(gotIn == expected);

        this.set_exit_fee_bps(bps);
        uint256 gotOut = this.settleExitFeeGivenGrossShares(gross);
        assert(gotOut == expected);
    }

    // Owed accounting invariants
    function prop_owed_accounting(uint256 a, uint256 b) external {
        address u = address(0xBEEF);
        uint256 beforeUser = getValueOwedToUser(u);
        uint256 beforeTotal = getTotalValueOwed();
        // increase then decrease
        unchecked {
            // simulate via public functions by using recipients
            __increaseValueOwed(u, a);
            __decreaseValueOwed(u, b % (a + 1));
        }
        uint256 afterUser = getValueOwedToUser(u);
        uint256 afterTotal = getTotalValueOwed();
        assert(afterUser + (beforeTotal + a) - (b % (a + 1)) == afterTotal);
        assert(afterUser >= 0);
    }

    // Claim reduces owed and transfers fee asset
    function prop_claim_reduces_owed(uint256 val) external {
        address u = address(0xCAFE);
        if (val == 0) return;
        __increaseValueOwed(u, val);
        // fund shares with fee asset
        feeAsset.mint(address(sharesMock), val);
        uint256 got = this.claimFees(u, val);
        assert(getValueOwedToUser(u) == 0);
        assert(got > 0);
    }
}

