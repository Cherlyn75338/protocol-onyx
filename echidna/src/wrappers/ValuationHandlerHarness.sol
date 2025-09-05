// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ValuationHandler} from "src/components/value/ValuationHandler.sol";

contract ValuationHandlerHarness is ValuationHandler {
    address private immutable _shares;
    constructor(address shares_) { _shares = shares_; }
    function SHARES() external view returns (address) { return _shares; }
}

