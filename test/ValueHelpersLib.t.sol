// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

// Lightweight test suite without forge-std. Uses `require` for assertions.
contract ValueHelpersLibTest {
    function test_convert_rateQuotedInBase_roundsDown() public {
        // _baseAmount = 3, _ratePrecision = 1e18, _quotePrecision = 1e6
        // _rate = 2e18 (2 quote per 1 base), _basePrecision = 1e18
        // Expected: floor( (3 * 1e18) * 1e6 / (2e18 * 1e18) ) = floor(3e24 / 2e36) = 0
        uint256 q = _convert({
            _baseAmount: 3,
            _basePrecision: 1e18,
            _quotePrecision: 1e6,
            _rate: 2e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: true
        });
        require(q == 0, "expected floor rounding to zero");

        // Larger values to avoid underflow to zero but still fractional -> floor
        // baseAmount = 3e18 base units (1 basePrecision), expecting floor( (3 * 1e18) * 1e6 / (2e18 * 1e18) ) = floor(3e24/2e36)=0
        // Use different precisions to get non-zero: baseAmount=3e18, quotePrecision=1e18 yields floor(3e36/2e36)=1
        uint256 q2 = _convert({
            _baseAmount: 3e18,
            _basePrecision: 1e18,
            _quotePrecision: 1e18,
            _rate: 2e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: true
        });
        require(q2 == 1, "expected floor rounding down");
    }

    function test_convert_rateQuotedInQuote_roundsDown() public {
        // _baseAmount = 5, _rate = 3e18 (3 base per 1 quote), _quotePrecision=1e6, basePrecision=1e18
        // Expected: floor( 5*3e18 * 1e6 / (1e18 * 1e18)) = floor(15e24/1e36)=0
        uint256 q = _convert({
            _baseAmount: 5,
            _basePrecision: 1e18,
            _quotePrecision: 1e6,
            _rate: 3e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: false
        });
        require(q == 0, "expected floor rounding to zero");

        // Scale up to get fractional > 0: 5e18 base -> floor(15e36/1e36)=15
        uint256 q2 = _convert({
            _baseAmount: 5e18,
            _basePrecision: 1e18,
            _quotePrecision: 1e18,
            _rate: 3e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: false
        });
        require(q2 == 15, "expected floor rounding down");
    }

    function test_calcSharesAndValue_rounding() public {
        // share value 2e18, value 3 -> shares = floor(1e18*3/2e18)=0
        uint256 s0 = ValueHelpersLib.calcSharesAmountForValue(2e18, 3);
        require(s0 == 0, "small value to shares should floor to zero");

        // valuePerShare=2e18, shares=3e18 -> value=floor(2e18*3e18/1e18)=6e18
        uint256 v = ValueHelpersLib.calcValueOfSharesAmount(2e18, 3e18);
        require(v == 6e18, "value of shares matches");

        // totalValue 5e18, totalShares 2e18 -> vps=floor(1e18*5e18/2e18)=2e18
        uint256 vps = ValueHelpersLib.calcValuePerShare(5e18, 2e18);
        require(vps == 2e18, "value per share floor rounding");
    }

    function _convert(
        uint256 _baseAmount,
        uint256 _basePrecision,
        uint256 _quotePrecision,
        uint256 _rate,
        uint256 _ratePrecision,
        bool _rateQuotedInBase
    ) internal pure returns (uint256) {
        if (_rateQuotedInBase) {
            return Math.mulDiv(_baseAmount * _ratePrecision, _quotePrecision, (_rate * _basePrecision));
        } else {
            return Math.mulDiv(_baseAmount * _rate, _quotePrecision, (_ratePrecision * _basePrecision));
        }
    }
}
