// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.28;

import {IChainlinkAggregator} from "src/interfaces/external/IChainlinkAggregator.sol";

/// @title AggregatorV3Mock
/// @notice Minimal aggregator mock for Echidna fuzzing with adjustable answer and timestamp
contract AggregatorV3Mock is IChainlinkAggregator {
    uint8 private immutable DEC;
    int256 private ans;
    uint256 private updatedAt;

    constructor(uint8 _decimals, int256 _answer, uint256 _updatedAt) {
        DEC = _decimals;
        ans = _answer;
        updatedAt = _updatedAt;
    }

    function decimals() external view override returns (uint8) {
        return DEC;
    }

    function setAnswer(int256 _answer) external {
        ans = _answer;
    }

    function setUpdatedAt(uint256 _updatedAt) external {
        updatedAt = _updatedAt;
    }

    function latestRoundData()
        external
        view
        override
        returns (uint80, int256 answer_, uint256, uint256 updatedAt_, uint80)
    {
        return (0, ans, 0, updatedAt, 0);
    }
}

