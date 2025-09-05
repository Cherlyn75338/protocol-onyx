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

    /// @notice Converting using aggregator with tolerance must revert when answer<=0 or timestamp stale
    function check_aggregator_validation(int256 answer, uint256 tolerance, bool quotedInBase) external {
        // Clamp tolerance to a sane bound to avoid impractical overflows
        tolerance = tolerance % (30 days);

        oracle.setAnswer(answer);
        oracle.setUpdatedAt(block.timestamp);

        if (answer <= 0) {
            bool ok;
            (ok,) = address(this).call(abi.encodeWithSelector(this.try_convert.selector, uint256(1e18), uint256(1e18), tolerance, quotedInBase));
            assert(!ok);
            return;
        }

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

