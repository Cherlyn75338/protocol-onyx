Deep Echidna Plan (outline for next harnesses)

1) Fee math harness (FeeHandler)
- Deploy minimal mock Shares exposing:
  - totalSupply mutable (settable by harness)
  - sharePrice() and shareValue() bridged from a harness-controlled ValuationHandler mock
  - getFeeHandler address injected
  - isDepositHandler/isRedeemHandler flags controllable
  - withdrawAssetTo, mintFor, burnFor behavior noop or tracked
- Properties:
  - settleEntranceFeeGivenGrossShares: feeShares = floor(gross*bps/10000); if bps==0 => 0
  - settleExitFeeGivenGrossShares: same invariant
  - claimFees decreases total/user owed by _value exactly and transfers fee asset amount equal to convertValueToAssetAmount(_value)
  - __increase/__decrease maintains total == sum of users (track per-user owed for 2-3 addresses)
  - Dynamic fee settlement monotonic with time and rates; performance fee zero when vps<=HWM

2) ValuationHandler harness
- Fuzz add/remove position trackers set; inject mock trackers returning int values
- setAssetRate then updateShareValue:
  - totalPositions = tracked + untracked >= 0
  - after settlement: lastShareValueTimestamp updated to now; lastShareValue in [0, 2^128-1]
  - If totalShares==0 => lastShareValue==0
  - With fees enabled: totalFeesOwed non-decreasing across settleDynamicFeesGivenPositionsValue unless claimFees called
  - Monotonicity: increasing tracked/untracked cannot reduce netShareValue when fees trackers disabled

3) Issuance queues harness
- Provide mock Shares with fee handler and valuation handler addresses
- For deposit:
  - requestDeposit(_assets>0) stores request with exact amount and canCancelTime = now + minDuration
  - executeDepositRequests burns queue, mints net shares > 0, emits events
  - sum of assets transferred to Shares equals sum of request.assetAmount for executed ids
- For redeem:
  - requestRedeem(_shares>0) pulls shares; cancellation returns same amount
  - executeRedeemRequests burns gross and transfers assets > 0 per conversion

4) Edge/rounding properties
- Verify that splitting a deposit into N parts does not increase total fees beyond N times single deposit fee rounded loss upper bound
- Verify that micro-deposits that would yield zero net shares are rejected (prevents rounding dust mints)
- Ensure convertTo/from asset/value round-trip error bounded by 1 unit as in ValueHelpers harness

5) Oracle safety
- Enforce that stale or non-positive answers revert; fuzz tolerance edges (0, large)
- Optional: add per-asset min/max and max step-change properties once implemented

