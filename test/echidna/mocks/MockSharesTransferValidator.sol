// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ISharesTransferValidator} from "src/interfaces/ISharesTransferValidator.sol";

contract MockSharesTransferValidator is ISharesTransferValidator {
    bool public wasCalled;
    address public lastFrom;
    address public lastTo;
    uint256 public lastAmount;

    function validateSharesTransfer(address _from, address _to, uint256 _amount) external override {
        wasCalled = true;
        lastFrom = _from;
        lastTo = _to;
        lastAmount = _amount;
    }

    function reset() external {
        wasCalled = false;
        lastFrom = address(0);
        lastTo = address(0);
        lastAmount = 0;
    }
}

