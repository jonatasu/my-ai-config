# Hermes Agent Adapter

Read `../AGENTIC-ENVIRONMENT.md` first, then `agentic.config.yaml`.

Hermes should map TARS to the sole orchestrator role. Implementers, reviewers,
validators, memory, and connector operations remain bounded capabilities.

If Hermes cannot spawn subagents or persist state, mark those capabilities as
partial and use the portable handoff and verification contracts.
