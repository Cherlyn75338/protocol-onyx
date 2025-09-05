// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";
import {MockAggregator} from "./mocks/MockAggregator.sol";

contract AggregatorConversionHarness {
    using ValueHelpersLib for uint256;

    MockAggregator public agg;

    constructor() {
        agg = new MockAggregator(18, 1e18);
    }

    function echidna_convert_with_agg_no_revert(
        uint256 baseAmount,
        uint8 baseDecimals,
        uint8 oracleDecimals,
        int256 answer,
        uint256 tolerance,
        bool quotedInBase
    ) external returns (bool) {
        baseDecimals = uint8(_bound(baseDecimals, 6, 18));
        oracleDecimals = uint8(_bound(oracleDecimals, 6, 24));
        uint256 basePrecision = 10 ** uint256(baseDecimals);
        uint256 quotePrecision = 1e18;
        tolerance = _bound(tolerance, 1, 30 days);
        if (answer <= 0) answer = 1; // ensure positive

        // configure aggregator
        agg.setAnswer(answer);

        if (quotedInBase) {
            ValueHelpersLib.convertWithAggregatorV3(
                baseAmount,
                basePrecision,
                quotePrecision,
                address(agg),
                10 ** uint256(oracleDecimals),
                tolerance,
                true
            );
        } else {
            ValueHelpersLib.convertWithAggregatorV3(
                baseAmount,
                basePrecision,
                quotePrecision,
                address(agg),
                10 ** uint256(oracleDecimals),
                tolerance,
                false
            );
        }
        return true;
    }

    function _bound(uint256 x, uint256 min, uint256 max) internal pure returns (uint256) {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }
}

