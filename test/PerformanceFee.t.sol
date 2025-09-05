// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

contract PerformanceFeeMathTest {
    // Mirrors core math from ContinuousFlatRatePerformanceFeeTracker
    function calcPerformanceFee(
        uint256 _netValue,
        uint256 _sharesSupply,
        uint256 _hwm,
        uint16 _rateBps
    ) public pure returns (uint256 valueDue_, uint256 nextHwm_) {
        if (_sharesSupply == 0) {
            return (0, 1e18);
        }
        uint256 valuePerShare = ValueHelpersLib.calcValuePerShare(_netValue, _sharesSupply);
        if (valuePerShare <= _hwm) return (0, _hwm);
        uint256 valueIncreasePerShare = valuePerShare - _hwm;
        uint256 valueIncrease = ValueHelpersLib.calcValueOfSharesAmount(valueIncreasePerShare, _sharesSupply);
        valueDue_ = (valueIncrease * _rateBps) / 10_000; // floor
        uint256 netValueIncludingFee = _netValue - valueDue_;
        nextHwm_ = ValueHelpersLib.calcValuePerShare(netValueIncludingFee, _sharesSupply);
    }

    function test_performanceFee_rounding_and_hwm_update() public {
        uint256 netValue = 10e18;
        uint256 shares = 5e18;
        uint256 hwm = 1e18;
        uint16 rate = 1000; // 10%

        (uint256 due, uint256 nextHwm) = calcPerformanceFee(netValue, shares, hwm, rate);
        // valuePerShare = floor(1e18*10e18/5e18)=2e18; increase per share=1e18; valueIncrease = 1e18*5e18/1e18=5e18
        // fee due = floor(5e18*1000/10000)=5e17
        require(due == 5e17, "fee due floors down");
        // next HWM = floor(1e18*(10e18-5e17)/5e18) = floor(1e18*9.5e18/5e18)=floor(1.9e18)=1.9e18
        require(nextHwm == 19e17, "next HWM floor rounding");
    }

    function test_performanceFee_small_increase_may_floor_to_zero() public {
        uint256 netValue = 1000; // tiny
        uint256 shares = 1e18;
        uint256 hwm = 0;
        uint16 rate = 1; // 0.01%

        (uint256 due, uint256 nextHwm) = calcPerformanceFee(netValue, shares, hwm, rate);
        // increase is tiny; due floors to zero
        require(due == 0, "tiny due floors to zero");
        require(nextHwm == ValueHelpersLib.calcValuePerShare(netValue, shares), "hwm updated to vps");
    }
}

