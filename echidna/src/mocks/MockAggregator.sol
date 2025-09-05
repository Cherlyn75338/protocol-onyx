// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {IChainlinkAggregator} from "src/interfaces/external/IChainlinkAggregator.sol";

contract MockAggregator is IChainlinkAggregator {
    uint8 private _decimals;
    int256 public answer;
    uint256 public updatedAt;

    constructor(uint8 dec, int256 ans) {
        _decimals = dec;
        answer = ans;
        updatedAt = block.timestamp;
    }

    function decimals() external view override returns (uint8 decimals_) {
        return _decimals;
    }

    function setAnswer(int256 ans) external {
        answer = ans;
        updatedAt = block.timestamp;
    }

    function latestRoundData()
        external
        view
        override
        returns (uint80, int256 answer_, uint256, uint256 updatedAt_, uint80)
    {
        return (0, answer, 0, updatedAt, 0);
    }
}

