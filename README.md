# Tests

This repo includes Foundry tests asserting rounding behavior and fee math:

- `test/ValueHelpersLib.t.sol`: Verifies OZ `Math.mulDiv`-based conversions round down as intended in `ValueHelpersLib` and that per-share/value conversions floor.
- `test/FeeRounding.t.sol`: Asserts entrance/exit fee share rounding and deposit/redeem math, checking that rounding favors the protocol and net outputs are consistent.
- `test/PerformanceFee.t.sol`: Validates performance fee calculation rounding and high water mark update logic on small/large values.

Run:

```
forge test -vv
```

# Onyx (by Enzyme Protocol)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

Onyx (by Enzyme Protocol) is a set of EVM-compatible smart contracts to tokenize on- and off-chain value.

For more information, see the Onyx General Spec [link forthcoming]

## Security Issues and Bug Bounty

If you find a vulnerability that may affect live deployments, you can submit a report via:

A. Immunefi (https://immunefi.com/bounty/enzymefinance/), or

B. Direct email to [security@enzyme.finance](mailto:security@enzyme.finance)

Please **DO NOT** open a public issue.

## Using this Repository

### Prerequisites

- [foundry](https://github.com/foundry-rs/foundry)

### Compile Contracts

```
forge build
```

### Run all tests

```
forge test
```

### Echidna

To run the Echidna invariants locally:

1) Install Echidna (`crytic-compile` and `echidna`) and Foundry toolchain.

2) From the project root, run:

```
echidna echidna/echidna.yaml
```

The harness is `echidna/OnyxEchidnaInvariants.sol:OnyxEchidnaInvariants` and deploys `Shares`, `ValuationHandler`, `FeeHandler`, fee trackers, and issuance queues. Key invariants include restricted access to sensitive methods, identity conversion at 1:1 rate for the mock asset, and fee accounting consistency.

## Licensing

- Source-available under Business Source License 1.1 (BUSL-1.1).
- See [LICENSES/BUSL-1.1](LICENSES/BUSL-1.1) for terms and change date.

SPDX identifiers:

- All first-party files: `BUSL-1.1`
- Vendored third-party files retain original identifiers (e.g., `MIT`).
