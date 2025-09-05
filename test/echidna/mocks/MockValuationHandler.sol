// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {MockERC20} from "test/echidna/mocks/MockERC20.sol";
import {VALUE_ASSET_PRECISION} from "src/utils/Constants.sol";

contract MockValuationHandler {
    mapping(address => uint8) public decimalsOf;
    mapping(address => uint256) public rateOf; // 18-dec rate

    function setAsset(address asset, uint8 dec, uint256 rate) external {
        decimalsOf[asset]=dec;
        rateOf[asset]=rate;
    }

    function convertAssetAmountToValue(address _asset, uint256 _assetAmount) external view returns (uint256) {
        uint8 dec = decimalsOf[_asset];
        uint256 basePrecision = 10 ** uint256(dec);
        return _assetAmount * rateOf[_asset] * VALUE_ASSET_PRECISION / basePrecision / 1e18;
    }

    function convertValueToAssetAmount(uint256 _value, address _asset) external view returns (uint256) {
        uint8 dec = decimalsOf[_asset];
        uint256 quotePrecision = 10 ** uint256(dec);
        return _value * 1e18 * quotePrecision / rateOf[_asset] / VALUE_ASSET_PRECISION;
    }
}

