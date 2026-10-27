# Feature Coverage Matrix

This matrix prevents duplicate implementation while the harness evolves.

| Capability | Existing surface | Status | Completion path |
|---|---|---|---|
| TARS orchestration | `agents/registry.yaml`, host adapters | Complete | Keep host mappings aligned with TARS |
| Subagent briefs | `.core/orchestration.md`, `.core/skills/subagent-briefs.md` | Complete | Keep brief fields aligned with host capabilities |
| Durable state | `.tools/harness/`, controller runtime | Partial | Add portable state and ledger contracts |
| Verification ledger | `verification/default.yaml`, `.core/skills/verification-ledger.md` | Complete | Bind every host record to current fingerprints |
| Session lifecycle | memory and handoff contracts, `.core/skills/session-lifecycle.md` | Complete | Keep pause/resume adapters aligned |
| Engineering principles | `.core/engineering-principles.md` | Complete | Add focused principle skills |
| Adversarial review | review adapter and closed loop | Partial | Add multi-lens review contract |
| Retry policy | closed-loop contract | Partial | Add fresh-agent retry classes and limits |
| Queue orchestration | harness runtime | Partial | Add inbox and drain semantics |
| Guard framework | `policies/permissions.yaml` | Partial | Add provider-neutral guard contracts |
| Skill lifecycle | skills index, `.core/skills/skill-lifecycle.md` | Complete | Add host-specific lifecycle tests |
| Capability mapping | host adapters, `.core/skills/capability-mapping.md` | Complete | Add explicit per-host support matrix |
| Feature Map generation | `.core/skills/generate-feature-map.md`, Playwright adapter | Complete | Validate generated maps against runtime evidence |
| Guardrail audit | `.core/skills/guardrail-audit.md`, quality and security skills | Complete | Add project-specific positive and negative fixtures |
| Codebase context | `.core/skills/codebase-context.md`, Repomix MCP | Complete | Keep Repomix sandboxed and read-only |
| Skill catalog MCP | provider tooling | Partial | Add optional read-only catalog adapter |
