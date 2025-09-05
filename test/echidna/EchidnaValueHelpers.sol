// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";
import {SHARES_PRECISION, VALUE_ASSET_PRECISION} from "src/utils/Constants.sol";

/// @title EchidnaValueHelpers
/// @notice Echidna harness to fuzz-test ValueHelpersLib math, rounding, and precision invariants
contract EchidnaValueHelpers {
    using ValueHelpersLib for uint256;

    // Accept any ether sent during deployment or fuzz runs
    constructor() payable {}
    receive() external payable {}

    // -------------------------
    // Shares/Value conversions
    // -------------------------

    /// @notice Check that converting value -> shares -> value is floor-rounded and bounded
    function check_shares_value_roundtrip(uint256 valuePerShare, uint256 value) external {
        // Pre-conditions to avoid division by zero and cap extremes
        require(valuePerShare > 0, "vps=0");

        uint256 shares = ValueHelpersLib.calcSharesAmountForValue({
            _valuePerShare: valuePerShare,
            _value: value
        });

        uint256 backToValue = ValueHelpersLib.calcValueOfSharesAmount({
            _valuePerShare: valuePerShare,
            _sharesAmount: shares
        });

        // Floor rounding: value after round-trip must not exceed original
        assert(backToValue <= value);

        // Tightness: adding one share should push us over or equal the original value (unless shares is max)
        if (shares < type(uint256).max) {
            uint256 backWithOneMore = ValueHelpersLib.calcValueOfSharesAmount({
                _valuePerShare: valuePerShare,
                _sharesAmount: shares + 1
            });
            assert(backWithOneMore >= value || backWithOneMore == backToValue);
        }
    }

    /// @notice Check monotonicity of calcValuePerShare when changing totalValue and totalShares
    function check_value_per_share_monotonic(
        uint256 totalValue,
        uint256 totalShares,
        uint256 addValue,
        uint256 subShares
    ) external {
        // Avoid division by zero
        totalShares = boundAtLeastOne(totalShares);

        uint256 vps0 = ValueHelpersLib.calcValuePerShare({_totalValue: totalValue, _totalSharesAmount: totalShares});

        // Increasing total value (holding shares constant) must not decrease vps
        uint256 vpsMoreValue = ValueHelpersLib.calcValuePerShare({
            _totalValue: totalValue + addValue,
            _totalSharesAmount: totalShares
        });
        assert(vpsMoreValue >= vps0);

        // Decreasing total shares (if any) must not decrease vps
        uint256 newShares = totalShares;
        if (subShares >= totalShares) {
            newShares = 1; // minimal shares to avoid zero
        } else {
            newShares = totalShares - subShares;
            if (newShares == 0) newShares = 1;
        }
        uint256 vpsLessShares = ValueHelpersLib.calcValuePerShare({_totalValue: totalValue, _totalSharesAmount: newShares});
        assert(vpsLessShares >= vps0);
    }

    /// @notice Test proportionality: k*x converted ~ k*convert(x) (floor rounding may reduce by < k)
    function check_convert_proportionality(
        uint256 baseAmount,
        uint256 basePrecision,
        uint256 quotePrecision,
        uint256 rate,
        uint256 ratePrecision,
        bool rateQuotedInBase,
        uint8 k
    ) external {
        // sanitize inputs
        basePrecision = boundPrecision(basePrecision);
        quotePrecision = boundPrecision(quotePrecision);
        ratePrecision = boundPrecision(ratePrecision);
        rate = boundNonZero(rate);
        baseAmount = baseAmount % type(uint128).max; // keep within practical bounds
        if (k == 0) {
            k = 1;
        }

        uint256 q1 = ValueHelpersLib.convert({
            _baseAmount: baseAmount,
            _basePrecision: basePrecision,
            _quotePrecision: quotePrecision,
            _rate: rate,
            _ratePrecision: ratePrecision,
            _rateQuotedInBase: rateQuotedInBase
        });

        uint256 qk = ValueHelpersLib.convert({
            _baseAmount: baseAmount * uint256(k),
            _basePrecision: basePrecision,
            _quotePrecision: quotePrecision,
            _rate: rate,
            _ratePrecision: ratePrecision,
            _rateQuotedInBase: rateQuotedInBase
        });

        // Monotonicity
        assert(qk >= q1);

        // Floor rounding: qk should be at most k*q1 + (k-1) rounding losses
        uint256 upper = q1 * uint256(k) + (k > 0 ? uint256(k - 1) : 0);
        assert(qk <= upper);
    }

    /// @notice Round-trip conversion between base and quote should be bounded by at most 1 unit of precision
    function check_convert_roundtrip(
        uint256 baseAmount,
        uint256 basePrecision,
        uint256 quotePrecision,
        uint256 rate,
        uint256 ratePrecision,
        bool rateQuotedInBase
    ) external {
        basePrecision = boundPrecision(basePrecision);
        quotePrecision = boundPrecision(quotePrecision);
        ratePrecision = boundPrecision(ratePrecision);
        rate = boundNonZero(rate);
        baseAmount = baseAmount % type(uint128).max;

        uint256 quoteAmount = ValueHelpersLib.convert({
            _baseAmount: baseAmount,
            _basePrecision: basePrecision,
            _quotePrecision: quotePrecision,
            _rate: rate,
            _ratePrecision: ratePrecision,
            _rateQuotedInBase: rateQuotedInBase
        });

        // Invert the quotation direction while keeping the numeric rate identical.
        // Note: using the same `rate` in opposite quotation directions does not yield perfect inversion
        // due to rounding and representation; we assert a bounded error of <= 1 unit of the starting precision.
        uint256 backToBase = ValueHelpersLib.convert({
            _baseAmount: quoteAmount,
            _basePrecision: quotePrecision,
            _quotePrecision: basePrecision,
            _rate: rate,
            _ratePrecision: ratePrecision,
            _rateQuotedInBase: !rateQuotedInBase
        });

        if (baseAmount == 0) {
            assert(backToBase == 0);
        } else {
            // Bound the absolute round-trip error by at most one base precision unit
            uint256 diff = backToBase > baseAmount ? backToBase - baseAmount : baseAmount - backToBase;
            assert(diff <= basePrecision);
        }
    }

    // -------------------------
    // Helpers
    // -------------------------

    function boundPrecision(uint256 p) internal pure returns (uint256) {
        if (p == 0) return 1;
        // cap to 1e36 to avoid extreme magnitudes (practical upper bound)
        if (p > 10 ** 36) return 10 ** 36;
        return p;
    }

    function boundAtLeastOne(uint256 x) internal pure returns (uint256) {
        return x == 0 ? 1 : x;
    }

    function boundNonZero(uint256 x) internal pure returns (uint256) {
        return x == 0 ? 1 : x;
    }
}

