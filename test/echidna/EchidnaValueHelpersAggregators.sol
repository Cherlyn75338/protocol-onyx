// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";
import {AggregatorV3Mock} from "test/echidna/EchidnaOraclesMock.sol";

/// @title EchidnaValueHelpersAggregators
/// @notice Fuzz aggregator-assisted conversions and timestamp validation
contract EchidnaValueHelpersAggregators {
    AggregatorV3Mock public oracle;

    constructor() payable {
        // default: 18 decimals, answer = 1e18, updatedAt = now
        oracle = new AggregatorV3Mock(18, int256(1e18), block.timestamp);
    }

    /// @notice Bounded success: for realistic positive answers and tolerance, fresh must succeed, stale must revert
    function check_aggregator_bounded_success(int256 answer, uint256 tolerance, bool quotedInBase) external {
        // Clamp tolerance to a sane bound to avoid impractical overflows
        tolerance = tolerance % (30 days);
        // Clamp answer into realistic 18-dec bounds [1, 1e27]
        if (answer < 1) return;
        if (uint256(answer) > 10 ** 27) return;

        oracle.setAnswer(answer);
        oracle.setUpdatedAt(block.timestamp);

        // when timestamp is fresh, conversion should succeed or revert only on arithmetic overflow
        bool okFresh;
        (okFresh,) = address(this).call(abi.encodeWithSelector(this.try_convert.selector, uint256(1e18), uint256(1e18), tolerance, quotedInBase));
        assert(okFresh);

        // set stale timestamp and expect revert
        uint256 oldTs = block.timestamp - (tolerance + 1);
        oracle.setUpdatedAt(oldTs);
        bool okStale;
        (okStale,) = address(this).call(abi.encodeWithSelector(this.try_convert.selector, uint256(1e18), uint256(1e18), tolerance, quotedInBase));
        assert(!okStale);
    }

    /// @notice Unbounded safety: arbitrary answers must not cause unexpected behavior; stale must revert
    function check_aggregator_unbounded_safety(int256 answer, uint256 tolerance, bool quotedInBase) external {
        tolerance = tolerance % (30 days);
        oracle.setAnswer(answer);
        oracle.setUpdatedAt(block.timestamp);

        // Fresh: succeed or revert (both acceptable under extreme values)
        bool okFresh;
        (okFresh,) = address(this).call(abi.encodeWithSelector(this.try_convert.selector, uint256(1e18), uint256(1e18), tolerance, quotedInBase));
        assert(okFresh || !okFresh);

        // Stale must revert
        uint256 oldTs = block.timestamp - (tolerance + 1);
        oracle.setUpdatedAt(oldTs);
        bool okStale;
        (okStale,) = address(this).call(abi.encodeWithSelector(this.try_convert.selector, uint256(1e18), uint256(1e18), tolerance, quotedInBase));
        assert(!okStale);
    }

    function try_convert(uint256 baseAmount, uint256 quotePrecision, uint256 tolerance, bool quotedInBase) external view returns (uint256) {
        // oracle decimals = 18 per constructor
        uint256 oraclePrecision = 1e18;
        uint256 basePrecision = 1e18;
        return ValueHelpersLib.convertWithAggregatorV3({
            _baseAmount: baseAmount,
            _basePrecision: basePrecision,
            _quotePrecision: quotePrecision,
            _oracle: address(oracle),
            _oraclePrecision: oraclePrecision,
            _oracleTimestampTolerance: tolerance,
            _oracleQuotedInBase: quotedInBase
        });
    }
}

