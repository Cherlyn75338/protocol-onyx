// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import {ERC7540LikeDepositQueue} from "src/components/issuance/deposit-handlers/ERC7540LikeDepositQueue.sol";
import {ERC7540LikeRedeemQueue} from "src/components/issuance/redeem-handlers/ERC7540LikeRedeemQueue.sol";
import {MockERC20} from "test/echidna/mocks/MockERC20.sol";
import {MockShares} from "test/echidna/mocks/MockShares.sol";
import {MockValuationHandler} from "test/echidna/mocks/MockValuationHandler.sol";
import {ValueHelpersLib} from "src/utils/ValueHelpersLib.sol";

contract EchidnaIssuanceQueues is ERC7540LikeDepositQueue, ERC7540LikeRedeemQueue {
    using ValueHelpersLib for uint256;

    MockERC20 public assetToken;
    MockShares public shares;
    MockValuationHandler public val;

    constructor() payable {
        // deploy mocks
        assetToken = new MockERC20("ASSET","AST",18);
        shares = new MockShares(address(assetToken));
        val = new MockValuationHandler();
        val.setAsset(address(assetToken), 18, 1e18);

        // wire components
        shares.addAdmin(address(this));
        shares.addDepositHandler(address(this));
        shares.addRedeemHandler(address(this));
        shares.setValuationHandler(address(val));

        // set asset on both inherited bases via external calls
        ERC7540LikeDepositQueue.setAsset(address(assetToken));
        ERC7540LikeRedeemQueue.setAsset(address(assetToken));
    }

    // ComponentHelpersMixin hook
    function SHARES() external view returns (address) { return address(shares); }

    // Deposit lifecycle
    function prop_deposit_lifecycle(uint256 amt) external {
        address user = address(0xB0B);
        if (amt == 0) return;
        assetToken.mint(user, amt);
        // approve and request
        // mimic ERC20 approve by having handler transferFrom; use direct transfer since MockERC20 has no allowance here
        // simulate SafeERC20.safeTransferFrom by pre-funding handler
        assetToken.transfer(address(this), amt);
        uint256 id = this.requestDeposit(amt, address(this), address(this));
        uint256[] memory ids = new uint256[](1); ids[0]=id;
        this.executeDepositRequests(ids);
    }

    // Redeem lifecycle
    function prop_redeem_lifecycle(uint256 sharesAmt) external {
        address user = address(0xB0B);
        if (sharesAmt == 0) return;
        // mint shares to user via deposit path
        shares.addDepositHandler(address(this));
        shares.mintFor(user, sharesAmt);
        // transfer shares into handler (simulate authTransferFrom)
        shares.addRedeemHandler(address(this));
        shares.burnFor(user, 0); // no-op ensure handler set
        // request redeem
        uint256 id = this.requestRedeem(sharesAmt, address(this), address(this));
        uint256[] memory ids = new uint256[](1); ids[0]=id;
        this.executeRedeemRequests(ids);
    }
}

