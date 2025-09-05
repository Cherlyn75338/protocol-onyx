Audit Prompt (Version 2–aware)

A lot of auditors focus on identifying mistakes in code — reverts, missing checks, typos. These matter, but the deeper and more dangerous issues often stem from code that behaves exactly as designed — just not as safely as assumed.

Mindset Shift

Your role is not to blindly scan for errors.

Your role is to:

- Think like an adversary.
- Read the entire codebase like your life depends on understanding every function call. No shortcuts.
- Understand what the protocol intends to do, then find ways to make it do something else.

Protocol Overview (as understood from the code and V2 spec)

- Shares is the central ERC20Upgradeable token with owner and admin roles. It maintains registries for deposit/redeem handlers and references fee and valuation modules. In Version 2, Shares is the sole token holder; prior wallet indirections (depositAssetsDest, feeAssetsSrc, redeemAssetsSrc) are removed.
- Issuance is split into asynchronous queues:
  - Deposits: ERC7540LikeDepositQueue holds ERC20 assets until admin executes requests and mints shares.
  - Redemptions: ERC7540LikeRedeemQueue escrows shares until admin executes requests and pays assets.
- Valuation: ValuationHandler computes share price in a configured value asset. Admins set per-asset prices directly (V2), manage tracker modules (e.g., AccountERC20Tracker, LinearCreditDebtTracker), aggregate tracked on-chain positions plus admin-reported untracked value, and settle dynamic fees through FeeHandler. All prices and values use 18-decimal value-asset precision.
- Fees: FeeHandler accrues management and performance fees via trackers, and entrance/exit fees on issuance/redemption. Fees accrue in value units and are paid out in a configured fee asset when claimed. Only owner/admin can claim in V2.
- Governance/Factories: Global owner controls beacons/factories (BeaconFactory, ComponentBeaconFactory) using Beacon/UUPS patterns. Components are deployed behind ComponentBeaconProxy and reference a specific Shares instance.
- Roles/Call Forwarders: OpenAccessLimitedCallForwarder and LimitedAccessLimitedCallForwarder forward a whitelisted set of calls, with Limited adding per-user gating.

Trust Model (Version 2)

- Global owner: fully trusted, controls factories; could drain via upgrades.
- Fund owner and admins: fully trusted for fund operation; can drain the system. Admins configure asset prices and are assumed to set correct, timely prices with no frontrunning exposure. Limited admins are fully trusted within their granted scope and could drain if empowered to do so.
- Fee recipients: minimally trusted; they can influence timing (e.g., frontrun valuation updates).
- Users: untrusted. May interact through queues; may deploy proxies via factories (trusted deployments by assumption). OpenAccessLimitedCallForwarder usage should only expose non-abusive actions.
- Price sources in V2: prices are admin-set. Admins must ensure value-asset consistency and freshness; the system does not enforce oracle provenance.
- Tokens: assumed not to be rebasing, fee-on-transfer, capped-transfer, or recipient-callback tokens.

Enumerate Entry Points

Document each external function users, fee recipients, limited admins, admins, or the owner can trigger, grouped by contract. For each, capture:

- Access control: onlyOwner, onlyAdminOrOwner, onlyFeeHandler, only{Deposit,Redeem}Handler, limited admin pathways via forwarders.
- State changes, token movements, and external calls.
- Preconditions and reliance on other modules’ invariants.

Key entry points to trace in depth:

- Shares: transfer, transferFrom, authTransfer, authTransferFrom, withdrawAssetTo, add/remove handlers/admins, set fee/valuation/validator, initialize/upgrade pathways.
- ERC7540LikeDepositQueue: requestDeposit, requestDepositReferred, cancelDeposit, executeDepositRequests, allowlist/restrictions configuration.
- ERC7540LikeRedeemQueue: requestRedeem, cancelRedeem, executeRedeemRequests, min duration configuration.
- ValuationHandler: setAssetRate, setAssetRatesThenUpdateShareValue, updateShareValue, conversions (value <-> asset), add/remove trackers.
- FeeHandler: set fee parameters and recipients, claimFees, settleDynamicFeesGivenPositionsValue, entrance/exit fee settlement paths.
- Trackers:
  - AccountERC20Tracker: init, addAsset/removeAsset, getPositionValue.
  - LinearCreditDebtTracker: addItem/removeItem/updateItem, getPositionValue.
- Factories/Beacons: setImplementation, deploy proxy flows.
- Call forwarders: addCall/removeCall, executeCalls, and user management in the limited variant.

Methodology

1) Trace execution flows
- For each entry point, trace from input to final state mutation. Identify branching conditions, authority checks, external calls, and all implicit assumptions.
- Map valuation and fees interleaving: ValuationHandler.__updateShareValue -> FeeHandler.settleDynamicFeesGivenPositionsValue -> fee trackers -> persistence of share value and timestamps.

2) Hunt by intent (theme-based sweeps)
- Fee calculation/settlement ordering and timestamp games.
- Issuance queue escrow and settlement correctness.
- Asset valuation freshness, precision, and admin-set pricing assumptions (V2 specifics).
- Role bypass or privilege escalation via call forwarders.
- ERC20 quirk surfaces during transfers and withdrawals.

Exploit Categories and Codebase-Specific Angles

Mathematics / Precision

- Over/underflows: Solidity 0.8 checked arithmetic; focus on signed math in LinearCreditDebtTracker and SafeCast usage.
- Division-by-zero: ValueHelpersLib.calcValuePerShare(_totalSharesAmount == 0) must be guarded at callsites.
  - Used in ValuationHandler.__updateShareValue only when sharesSupply > 0.
  - Used in ContinuousFlatRatePerformanceFeeTracker with sharesSupply > 0 checks.
- Rounding/precision:
  - Fee basis points truncation may leave dust; confirm business intent and rounding direction.
  - ValueHelpersLib.convert uses mulDiv for full precision; verify _ratePrecision and token decimals alignment.
  - Management fee accrual uses secondsSinceSettlement / SECONDS_IN_YEAR; confirm acceptable year model.
  - Performance fee HWM on price reduces net value by fee due; inspect compounding/path dependence risk.

Timing / Freshness

- ValuationHandler.getSharePrice() does not assert timestamp freshness; acknowledged by design. Stale values can skew issuance/redemption and dynamic fees.
- Dynamic fee trackers (HWM/lastSettled) do not validate timestamp/price freshness; ensure initialization and update sequencing is safe.
- In V2, admins set asset prices directly with optional expiry semantics in conversions; long expiries or incorrect prices are governance risks.

Access Control / Auth

- Shares.withdrawAssetTo: callable by admin, redeem handler, or FeeHandler. Confirm that FeeHandler cannot withdraw arbitrary assets beyond fee claims. As currently designed, if FeeHandler is authorized as caller, it can withdraw any ERC20 from Shares. Treat as high-privilege and require strong governance; consider adding asset allowlists or restricting to the configured feeAsset and bounded by accrued fees.
- OpenAccessLimitedCallForwarder.executeCalls: any user can execute allowed selectors on allowed targets. Ensure only safe selectors are added. It does not enforce that the sum of per-call value equals msg.value; document behavior or optionally assert.
- LimitedAccessLimitedCallForwarder adds per-user gating; verify toggles and call lists.

Issuance Queues

- ERC7540LikeDepositQueue:
  - Requires _owner == msg.sender == _controller; no delegated deposits by default. Optional controller allowlist via restriction module.
  - Admin executes requests arbitrarily; no FIFO enforcement. Potential MEV or favoritism.
  - Share price used at execution time; admins can game timing by updating prices/valuation around execution.
  - Fee-on-transfer tokens break accounting assumptions; not supported per token assumptions.

- ERC7540LikeRedeemQueue:
  - Shares escrow via authTransferFrom by redeem handler; bypasses standard allowance.
  - Same timing/fairness risks as deposits.
  - Requires positive asset payout; handles zero/invalid states via reverts.

Fee System

- FeeHandler.settleDynamicFeesGivenPositionsValue:
  - Input should be total positions value before deducting unclaimed fees; FeeHandler subtracts current fees owed internally.
  - Settlement order: management fee then performance fee on the post-management-fee base.
  - Entrance/Exit fees computed on gross shares using sharePrice; if recipient is zero, fees are burned/distributed to shareholders.
  - claimFees converts value-owed to feeAsset amount using ValuationHandler conversion. Requires configured feeAsset and valid rate.
  - High privilege: FeeHandler may be allowed to call Shares.withdrawAssetTo; ensure this cannot be abused to drain arbitrary assets.

Valuation

- __updateShareValue aggregates signed values from trackers and untracked input; casting negative totals to uint reverts. Net value stored with block.timestamp; no freshness guard on trackers.
- Conversions rely on admin-set asset rates with expiry checks where applicable.

Trackers

- AccountERC20Tracker: initialization must not be publicly hijackable; ensure only authorized initializer can set tracked account.
- LinearCreditDebtTracker: examine integer math boundaries, especially for large durations and values; confirm no int256 overflows.

Upgradeability / Proxies

- UUPS/Beacon owner-only authorization. Verify initializer protections and consistent storage slots; V2 uses hardcoded storage locations validated in constructors.
- BeaconFactory and ComponentBeaconFactory governance: setImplementation owner-only, Create2 salts, and global upgrades affect all proxies.

ERC20 / Token Handling Risks

- Non-standard ERC20s: SafeERC20 mitigates return-value quirks, but accounting assumes 1:1 transfers; incompatible with fee-on-transfer and rebasing tokens per assumptions.
- Shares.transfer can be gated by an external validator; validator misbehavior can DOS transfers.
- authTransfer paths allow handlers to move shares they hold to users; confirm intended usage only.

Concrete Hypotheses to Test

- FeeHandler arbitrary withdrawal: Attempt FeeHandler -> Shares.withdrawAssetTo on arbitrary _asset not equal to feeAsset. Impact: loss of any token held by Shares if FeeHandler compromised/misconfigured. Severity: high. Mitigations: restrict withdraws to feeAsset and to accrued-fee bounds, or remove direct privilege.
- Issuance timing manipulation: Admins set favorable asset rates/untracked values, execute chosen requests, then revert prices. Impact: value transfer between cohorts. Mitigations: enforce freshness, limit rate change velocity, FIFO, TWAP or oracle-only pricing, or commit/reveal execution windows.
- Tracker initialization: Ensure performance/management trackers and AccountERC20Tracker are initialized correctly; otherwise settlement may revert or miscompute. Mitigations: guarded auto-init or explicit deployment checklist.
- Call forwarder value handling: msg.value mismatch across multicalls can strand ETH; document or assert sum(values) == msg.value.
- AccountERC20Tracker.init access control: prevent third-party front-run initialization. Mitigation: restrict to onlyAdminOrOwner or factory-only initialization.

Module-Specific Checklists

- Shares
  - Verify onlyAdminOrOwner paths and registry updates.
  - Evaluate withdrawAssetTo privilege surfaces.
  - External validator effects on transfer; low reentrancy risk but possible DOS.
  - Mint/Burn strictly gated to handlers; confirm registry governance.

- DepositQueue
  - Min request duration types (uint24/uint40) safe vs overflow.
  - Controller allowlist enforcement in restriction module.
  - Reentrancy considerations around ERC20 callbacks; consider guard if needed.
  - executeDepositRequests reads sharePrice once for consistency.

- RedeemQueue
  - Similar timing/reentrancy considerations. Uses Shares.withdrawAssetTo for payout.

- FeeHandler
  - Verify fee math ordering on net vs gross where intended.
  - Conversions require valid rates; claimFees should revert safely if misconfigured.
  - Prevent underflow by ensuring deltas <= owed.

- ValuationHandler
  - Negative totals revert; test tracker boundaries and sign handling.
  - Enforce rate expiry in conversions; no hidden fallbacks.

- Trackers
  - AccountERC20Tracker initializer access control.
  - LinearCreditDebtTracker arithmetic limits.

- Factories / Beacons / Global
  - Owner-only setImplementation; initial owner from Global.
  - UUPS _authorizeUpgrade owner-only.

Deliverables

For each entry point:

- Impact category: math, auth, timing/freshness, upgradeability, logic.
- Exploit path: exact call sequence and state prerequisites.
- Example attack scenario: realistic parameters and on-chain effects.
- Mitigations: minimal-surface hardening, stricter ownership and module bindings, defense-in-depth, optional guards.

Final Advice

- Do not just read the code — challenge assumptions, especially where V2 centralizes price setting and token custody in Shares.
- Where safety relies on off-chain governance, flag operational dependencies and propose feasible on-chain guardrails.
- Focus where math truncates silently, timestamps govern fee accrual, or powerful modules (fee handler, valuation handler, call forwarders) can operate “too well.”

