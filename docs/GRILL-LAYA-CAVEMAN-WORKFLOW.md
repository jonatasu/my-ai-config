# Grill, Laya, and Caveman Workflow

This document defines the portable lifecycle for consequential engineering
decisions and non-trivial executable changes.

## Roles

### Grill

Grill stress-tests the plan before implementation. It exposes assumptions,
scope boundaries, dependencies, failure modes, rollback, security, testing,
observability, and maintenance cost.

Grill does not implement changes, replace engineering judgment, or continue
after the decision frontier is settled.

### Laya

Laya evaluates complete, current evidence after implementation checks. It is a
structured decision signal, not the primary reasoner or sole approval authority.

Required statuses:

- `PASS`: evidence supports acceptance;
- `REVIEW`: uncertainty, abstention, or low confidence requires investigation;
- `BLOCK`: confirmed requirement, correctness, security, or verification failure.

### Caveman

Caveman compresses internal communication after the Laya decision. It reduces
context cost without deleting evidence required to reproduce or challenge the
decision.

Caveman is not a quality gate and must not rewrite user-facing output by
default.

## Canonical lifecycle

```text
user intent
  -> inspect facts and constraints
  -> Grill plan or architecture when consequential
  -> settle decisions and confirm shared understanding
  -> define acceptance criteria
  -> implement smallest complete change
  -> run required checks
  -> submit complete, uncompressed evidence to Laya
  -> inspect Laya signal with engineering judgment
  -> correct confirmed REVIEW/BLOCK findings
  -> rerun stale checks and Laya
  -> compress internal reports, checkpoints, and handoffs
  -> report result in normal language
```

## Gates

### Grill gate

Required before:

- architecture, API, schema, or data-model changes;
- security, privacy, compliance, deployment, or migration decisions;
- plans with materially different implementation options;
- ambiguous work that could create irreversible rework.

Skip for routine fixes, factual questions, documentation-only edits, and
well-scoped local changes whose constraints are already explicit.

Stop grilling when material assumptions are tested, remaining uncertainty is
explicit, and the user confirms the shared understanding.

### Laya gate

Required for:

- non-trivial executable changes;
- configuration changes;
- shared business logic;
- pre-PR quality gates.

Inputs must include the requirement, acceptance criteria, current diff, and
current check results. Submit them uncompressed. If Laya is unavailable when
required, return `BLOCK`; never convert unavailable evidence into `PASS`.

### Caveman gate

Allowed only after Laya has evaluated the evidence. Compress internal reports,
repetitive logs, completed checkpoints, and handoffs. Preserve requirements,
acceptance criteria, paths, line numbers, tests, confidence, statuses, and open
findings.

## Host mapping

| Capability | GitHub Copilot CLI | OpenCode |
|---|---|---|
| Grill entry point | Host skill or command | `/grill-me` and `grilling` skill |
| Laya transport | Laya plugin/MCP, CLI fallback | Laya MCP, `laya-gate`, CLI fallback |
| Laya commands | `laya-check`, `laya-review`, `laya-pr` | `laya-check`, `laya-review`, `laya-pr` |
| Caveman | Installed plugin and Cavecrew agents | Native skills and Cavecrew agents |
| Post-edit reminder | Supported by Copilot hook | Degraded on OpenCode 2.2.0; no supported V2 tool hook |
| User-facing output | Normal unless Caveman mode explicitly active | Normal by default |

Host adapters may add reminders or automation, but must not change the gate
ordering or weaken evidence and permission requirements.

## Failure handling

- Grill uncertainty: ask the next decision-changing question; do not guess.
- Laya `REVIEW`: investigate, correct when warranted, rerun checks, and rerun
  Laya within the host retry budget.
- Laya `BLOCK`: stop completion until the confirmed issue is resolved.
- Caveman compression failure: retain the uncompressed artifact and report the
  failure; never treat compression as evidence validation.

## Security

Do not send secrets, private keys, credentials, customer data, or unnecessary
personal data to Grill, Laya, or persistent compressed artifacts. Keep local
transports local and use host-managed credentials where required.
