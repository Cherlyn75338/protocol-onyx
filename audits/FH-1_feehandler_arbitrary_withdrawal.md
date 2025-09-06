## FH-1: FeeHandler can withdraw arbitrary assets from Shares

## Brief/Intro
The `Shares.withdrawAssetTo` function authorizes calls from the configured `FeeHandler` address without constraining the asset or the amount. If the `FeeHandler` is compromised, malicious, or misconfigured, it can unilaterally transfer any ERC20 held by `Shares` to an arbitrary address, bypassing fee accounting and the configured `feeAsset`. Given that v2 centralizes custody in `Shares`, exploitation would enable a full drain of fund-owned ERC20 assets.

## Vulnerability Details
`Shares.withdrawAssetTo` allows three caller classes: owner/admin, any redeem handler, or the `FeeHandler` address. For the `FeeHandler` case, the authorization is identity-based only; there is no binding to `feeAsset`, fee liabilities, or any quantitative cap.

```390:399:src/shares/Shares.sol
/// @dev Callable by: admin, RedeemHandler, FeeHandler
function withdrawAssetTo(address _asset, address _to, uint256 _amount) external {
    require(
        isAdminOrOwner(msg.sender) || isRedeemHandler(msg.sender) || msg.sender == getFeeHandler(),
        Shares__WithdrawAssetTo__Unauthorized()
    );

    IERC20(_asset).safeTransfer(_to, _amount);

    emit AssetWithdrawn({caller: msg.sender, asset: _asset, to: _to, amount: _amount});
}
```

In contrast, the intended fee payout path (`FeeHandler.claimFees`) converts value owed to the configured `feeAsset`, decrements accounting, and then instructs `Shares` to transfer that asset. That path is bounded by accounting, but it is not enforced at the `Shares` layer; a `FeeHandler` can make arbitrary withdrawals outside `claimFees`.

```194:208:src/components/fees/FeeHandler.sol
function claimFees(address _onBehalf, uint256 _value) external onlyAdminOrOwner returns (uint256 feeAssetAmount_) {
    Shares shares = Shares(__getShares());
    ValuationHandler valuationHandler = ValuationHandler(shares.getValuationHandler());
    address feeAsset = getFeeAsset();

    feeAssetAmount_ = valuationHandler.convertValueToAssetAmount({_value: _value, _asset: feeAsset});
    require(feeAssetAmount_ > 0, FeeHandler__ClaimFees__ZeroFeeAsset());

    __decreaseValueOwed({_user: _onBehalf, _delta: _value});

    shares.withdrawAssetTo({_asset: feeAsset, _to: _onBehalf, _amount: feeAssetAmount_});
}
```

Two new tests confirm the breadth of this privilege:
- `test_feeAsset_config_doesNotRestrict_withdrawals`: Setting `feeAsset` to token A did not prevent the `FeeHandler` identity from withdrawing token B from `Shares`.
- `testFuzz_feeHandler_withdrawArbitraryAsset(uint256,uint256)`: For random assets and bounded amounts, withdrawals succeed whenever the caller is the `FeeHandler`.

Therefore, the `FeeHandler` identity can withdraw arbitrary assets and amounts from `Shares`, independent of fee configuration or accounting.

## Impact Details
- If `FeeHandler` is malicious, compromised, or upgraded to malicious code, it can drain any ERC20 balance held by `Shares` in a single or multiple calls.
- The configured `feeAsset` and fee accounting do not constrain this path; they only affect the `claimFees` flow.
- Because v2 centralizes custody into `Shares`, this authorization represents a single-contract total-drain capability if the `FeeHandler` trust assumption fails.

Impact scope and losses:
- Loss of all ERC20 assets held by `Shares` (deposit assets, redeem assets staged in `Shares`, fee assets, etc.).
- Secondary effects include permanent insolvency of the fund and inability to honor redemptions.

Severity: High.

## References
- `Shares.withdrawAssetTo` caller checks and transfer: `src/shares/Shares.sol`
- `FeeHandler.claimFees` flow and feeAsset usage: `src/components/fees/FeeHandler.sol`
- Confirming tests: `test/FeeHandler_ArbitraryWithdraw.t.sol`

## Proof of Concept

1) Identity-only authorization in `Shares`:

```390:399:src/shares/Shares.sol
require(
    isAdminOrOwner(msg.sender) || isRedeemHandler(msg.sender) || msg.sender == getFeeHandler(),
    Shares__WithdrawAssetTo__Unauthorized()
);
IERC20(_asset).safeTransfer(_to, _amount);
```

2) Negative test showing `feeAsset` does not restrict arbitrary withdrawals:

```test/FeeHandler_ArbitraryWithdraw.t.sol
function test_feeAsset_config_doesNotRestrict_withdrawals() public {
    // ... set feeAsset = token A, seed token B (victim) into Shares ...
    vm.prank(address(mal));
    shares.withdrawAssetTo({_asset: address(victimAsset), _to: receiver, _amount: amount});
    // assert victimAsset moved to receiver
}
```

3) Fuzz test withdrawing random assets and amounts within `Shares` balances:

```test/FeeHandler_ArbitraryWithdraw.t.sol
function testFuzz_feeHandler_withdrawArbitraryAsset(uint256 selector, uint256 amountSeed) public {
    // pick asset by selector % N, bound amount to Shares' balance
    vm.prank(address(mal));
    shares.withdrawAssetTo({_asset: address(target), _to: receiver, _amount: amount});
    // assert balance decreased and receiver credited
}
```

Observed: All tests pass; 256 fuzz runs succeed. This demonstrates that the `FeeHandler` identity can drain any ERC20 from `Shares`, unconstrained by `feeAsset` or fee accounting.

