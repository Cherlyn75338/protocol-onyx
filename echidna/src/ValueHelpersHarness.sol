// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

/// @notice Wrapper exposing internal/pure functions for Echidna
contract ValueHelpersHarness {
    using ValueHelpersLib for uint256;

    // Direct library calls
    function echidna_convert_no_revert(
        uint256 baseAmount,
        uint256 basePrecision,
        uint256 quotePrecision,
        uint256 rate,
        uint256 ratePrecision,
        bool rateQuotedInBase
    ) external pure returns (bool) {
        // Bound inputs to avoid division by zero and keep within broad sane ranges
        basePrecision = _bound(basePrecision, 1, 1e30);
        quotePrecision = _bound(quotePrecision, 1, 1e30);
        rate = _bound(rate, 1, 1e30);
        ratePrecision = _bound(ratePrecision, 1, 1e30);

        // Should not revert for a broad range
        ValueHelpersLib.convert(baseAmount, basePrecision, quotePrecision, rate, ratePrecision, rateQuotedInBase);
        return true;
    }

    function echidna_roundtrip_asset_to_value(
        uint256 assetAmount,
        uint8 assetDecimals,
        uint256 rate,
        uint256 ratePrecision,
        bool rateQuotedInBase
    ) external pure returns (bool) {
        assetDecimals = uint8(_bound(assetDecimals, 6, 18));
        uint256 basePrecision = 10 ** uint256(assetDecimals);
        uint256 quotePrecision = 1e18; // value asset
        rate = _bound(rate, 1, 1e24);
        ratePrecision = _bound(ratePrecision, 1, 1e24);

        uint256 value = ValueHelpersLib.convert(assetAmount, basePrecision, quotePrecision, rate, ratePrecision, false);
        uint256 back = ValueHelpersLib.convert(value, quotePrecision, basePrecision, rate, ratePrecision, true);
        // P1: back <= assetAmount, loss bounded by 1 unit of asset
        if (back > assetAmount) return false;
        return (assetAmount - back) <= 1;
    }

    function echidna_roundtrip_value_to_asset(
        uint256 valueAmount,
        uint8 assetDecimals,
        uint256 rate,
        uint256 ratePrecision
    ) external pure returns (bool) {
        assetDecimals = uint8(_bound(assetDecimals, 6, 18));
        uint256 basePrecision = 10 ** uint256(assetDecimals);
        uint256 quotePrecision = 1e18; // value asset
        rate = _bound(rate, 1, 1e24);
        ratePrecision = _bound(ratePrecision, 1, 1e24);

        uint256 assets = ValueHelpersLib.convert(valueAmount, quotePrecision, basePrecision, rate, ratePrecision, true);
        uint256 back = ValueHelpersLib.convert(assets, basePrecision, quotePrecision, rate, ratePrecision, false);
        if (back > valueAmount) return false;
        return (valueAmount - back) <= 1;
    }

    function echidna_shares_monotone(uint256 s, uint256 v1, uint256 v2) external pure returns (bool) {
        s = _bound(s, 1, type(uint128).max);
        uint256 left = ValueHelpersLib.calcSharesAmountForValue(s, v1 + v2);
        uint256 right = ValueHelpersLib.calcSharesAmountForValue(s, v1)
            + ValueHelpersLib.calcSharesAmountForValue(s, v2);
        return left >= right;
    }

    function echidna_value_monotone(uint256 s, uint256 a1, uint256 a2) external pure returns (bool) {
        s = _bound(s, 1, type(uint128).max);
        uint256 left = ValueHelpersLib.calcValueOfSharesAmount(s, a1 + a2);
        uint256 right = ValueHelpersLib.calcValueOfSharesAmount(s, a1)
            + ValueHelpersLib.calcValueOfSharesAmount(s, a2);
        return left >= right;
    }

    function echidna_vps_bound(uint256 totalValue, uint256 totalShares) external pure returns (bool) {
        totalShares = _bound(totalShares, 1, type(uint128).max);
        uint256 vps = ValueHelpersLib.calcValuePerShare(totalValue, totalShares);
        uint256 recovered = ValueHelpersLib.calcValueOfSharesAmount(vps, totalShares);
        if (recovered > totalValue) return false;
        // Difference bounded by 1e18 due to 18-decimal shares precision
        return (totalValue - recovered) < 1e18;
    }

    function _bound(uint256 x, uint256 min, uint256 max) internal pure returns (uint256) {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }
}

