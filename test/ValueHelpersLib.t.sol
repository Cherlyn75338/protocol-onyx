// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

// Lightweight test suite without forge-std. Uses `require` for assertions.
contract ValueHelpersLibTest {
    function test_convert_rateQuotedInBase_roundsDown() public {
        // Convert value (1e18 precision) to asset (1e6 precision), rate quoted in base (value per asset)
        // value = 5e18, rate = 2e18 (2 value per 1 asset) => expected assets = floor((5/2)) = 2.5 => 2_500_000
        uint256 assets = _convert({
            _baseAmount: 5e18,
            _basePrecision: 1e18,
            _quotePrecision: 1e6,
            _rate: 2e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: true
        });
        require(assets == 2_500_000, "expected floor rounding to 2_500_000");

        // Another fractional case: value=1e18, rate=3e18 -> 0.333333... assets -> 333_333
        uint256 assets2 = _convert({
            _baseAmount: 1e18,
            _basePrecision: 1e18,
            _quotePrecision: 1e6,
            _rate: 3e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: true
        });
        require(assets2 == 333_333, "expected floor rounding to 333_333");
    }

    function test_convert_rateQuotedInQuote_roundsDown() public {
        // Convert asset (1e6 precision) to value (1e18 precision), rate quoted in quote (value per base unit)
        // assetAmount=3e6, rate=2e18 => expected value = 6e18
        uint256 value = _convert({
            _baseAmount: 3e6,
            _basePrecision: 1e6,
            _quotePrecision: 1e18,
            _rate: 2e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: false
        });
        require(value == 6e18, "expected 6e18 value");

        // assetAmount=1e6, rate=3e18 => expected value = 3e18
        uint256 value2 = _convert({
            _baseAmount: 1e6,
            _basePrecision: 1e6,
            _quotePrecision: 1e18,
            _rate: 3e18,
            _ratePrecision: 1e18,
            _rateQuotedInBase: false
        });
        require(value2 == 3e18, "expected 3e18 value");
    }

    function test_calcSharesAndValue_rounding() public {
        // valuePerShare=2e18, value=3e18 -> shares=floor(1e18*3e18/2e18)=1.5e18
        uint256 shares = ValueHelpersLib.calcSharesAmountForValue(2e18, 3e18);
        require(shares == 15e17, "shares should be 1.5e18");

        // valuePerShare=2e18, shares=3e18 -> value=floor(2e18*3e18/1e18)=6e18
        uint256 v = ValueHelpersLib.calcValueOfSharesAmount(2e18, 3e18);
        require(v == 6e18, "value of shares matches");

        // totalValue 5e18, totalShares 2e18 -> vps=floor(1e18*5e18/2e18)=2.5e18
        uint256 vps = ValueHelpersLib.calcValuePerShare(5e18, 2e18);
        require(vps == 25e17, "value per share floor rounding");
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
