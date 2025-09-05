// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {MockERC20} from "test/echidna/mocks/MockERC20.sol";

contract MockShares {
    address public feeHandler;
    address public valuationHandler;
    mapping(address => bool) public isDepositHandler;
    mapping(address => bool) public isRedeemHandler;
    mapping(address => bool) public isAdmin;
    address public owner;
    MockERC20 public immutable asset;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(address _asset) {
        asset = MockERC20(_asset);
        owner = msg.sender;
    }

    function setFeeHandler(address _fee) external { require(msg.sender==owner || isAdmin[msg.sender], "auth"); feeHandler=_fee; }
    function setValuationHandler(address _val) external { require(msg.sender==owner || isAdmin[msg.sender], "auth"); valuationHandler=_val; }
    function addAdmin(address a) external { require(msg.sender==owner, "owner"); isAdmin[a]=true; }
    function addDepositHandler(address a) external { require(msg.sender==owner || isAdmin[msg.sender], "auth"); isDepositHandler[a]=true; }
    function addRedeemHandler(address a) external { require(msg.sender==owner || isAdmin[msg.sender], "auth"); isRedeemHandler[a]=true; }

    function getFeeHandler() external view returns (address){ return feeHandler; }
    function getValuationHandler() external view returns (address){ return valuationHandler; }
    function isAdminOrOwner(address who) external view returns (bool){ return who==owner || isAdmin[who]; }

    function mintFor(address to, uint256 amount) external { require(isDepositHandler[msg.sender], "dep"); totalSupply+=amount; balanceOf[to]+=amount; }
    function burnFor(address from, uint256 amount) external { require(isRedeemHandler[msg.sender], "red"); require(balanceOf[from]>=amount, "bal"); balanceOf[from]-=amount; totalSupply-=amount; }

    function withdrawAssetTo(address _asset, address _to, uint256 _amount) external {
        require(isAdmin[msg.sender] || isRedeemHandler[msg.sender] || msg.sender==feeHandler, "auth");
        require(_asset==address(asset), "asset");
        asset.transfer(_to, _amount);
    }
}

