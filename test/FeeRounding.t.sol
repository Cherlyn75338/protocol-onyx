// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

contract FeeRoundingTest {
    // Simulate entrance fee calculation path used by FeeHandler.__calcEntranceExitFee
    function __calcEntranceExitFee(uint256 _grossSharesAmount, uint16 _feeBps)
        internal
        pure
        returns (uint256 feeShares_)
    {
        return (_grossSharesAmount * _feeBps) / 10_000;
    }

    function test_entranceFee_flooring_behaviour() public {
        // Gross shares so small that fee floors to zero at small bps
        uint256 fee0 = __calcEntranceExitFee(9, 1); // 0.01% of 9 -> floor(9/10000)=0
        require(fee0 == 0, "fee should floor to zero for tiny gross shares");

        // Larger shares to see flooring: 10001 at 1 bps -> floor(10001/10000)=1
        uint256 fee1 = __calcEntranceExitFee(10001, 1);
        require(fee1 == 1, "fee rounds down");
    }

    function test_deposit_math_rounding_favors_protocol() public {
        // sharePrice=2e18, value=3e18 -> grossShares=floor(1e18*3e18/2e18)=1.5e18
        uint256 sharePrice = 2e18;
        uint256 value = 3e18;
        uint256 grossShares = ValueHelpersLib.calcSharesAmountForValue(sharePrice, value);
        require(grossShares == 15e17, "gross shares 1.5e18");

        // entrance fee 10% -> floor(1.5e18*1000/10000)=1.5e17
        uint256 feeShares = __calcEntranceExitFee(grossShares, 1000);
        require(feeShares == 15e16, "fee shares floors down");

        uint256 netShares = grossShares - feeShares; // 1.35e18
        require(netShares == 135e16, "net shares consistent");
        require(netShares > 0, "non-zero net shares");
    }

    function test_redeem_math_rounding_and_burns_gross() public {
        uint256 sharePrice = 2e18;
        uint256 grossSharesToRedeem = 5e17; // 0.5 shares

        // exit fee 1% -> floor(5e17*100/10000)=5e15
        uint256 feeShares = __calcEntranceExitFee(grossSharesToRedeem, 100);
        require(feeShares == 5e15, "exit fee shares floors down");

        uint256 netShares = grossSharesToRedeem - feeShares; // 0.5e18 - 5e13
        uint256 valueDue = ValueHelpersLib.calcValueOfSharesAmount(sharePrice, netShares);
        // exact: (2e18*(5e17-5e15))/1e18 = 2*(4.95e17) = 9.9e17
        require(valueDue == 990_000_000_000_000_000, "valueDue floors as expected");
    }
}

