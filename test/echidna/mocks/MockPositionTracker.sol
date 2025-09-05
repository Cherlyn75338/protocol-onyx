// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {IPositionTracker} from "src/components/value/position-trackers/IPositionTracker.sol";

contract MockPositionTracker is IPositionTracker {
    int256 public value;

    function setValue(int256 v) external {
        value = v;
    }

    function getPositionValue() external view override returns (int256) {
        return value;
    }
}

