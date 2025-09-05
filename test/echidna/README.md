Echidna Fuzzing Suite

Targets
- EchidnaValueHelpers.sol: fuzzes ValueHelpersLib core math, rounding, monotonicity, proportionality, and round-trip bounds
- EchidnaValueHelpersAggregators.sol + AggregatorV3Mock: fuzzes aggregator-based conversions and timestamp validation

Run
1) Install echidna-test (Crytic/Echidna)
2) From repo root:
   echidna-test /workspace/test/echidna/EchidnaValueHelpers.sol --config /workspace/test/echidna/config.yaml
   echidna-test /workspace/test/echidna/EchidnaValueHelpersAggregators.sol --config /workspace/test/echidna/config.yaml

Notes
- Properties rely on assert; Echidna runs in assertion mode per config.
- Remaps include src/ and test/echidna/ for mocks.

