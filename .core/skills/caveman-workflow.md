# Laya and Caveman Workflow

Use Caveman compression as an internal efficiency layer, not as a substitute
for evidence, review, or reasoning.

## Required sequence

1. Collect complete evidence.
2. Run the required checks.
3. Submit uncompressed evidence to the decision gate, such as Laya.
4. Interpret the decision with manual engineering judgment.
5. Correct findings and repeat the required checks when needed.
6. Compress internal reports, logs, and handoffs after the decision.
7. Keep user-facing results in normal language.

## Automatic compression is appropriate for

- subagent reports
- repetitive tool output
- long test or build logs
- completed-work checkpoints
- internal handoffs
- context-pressure reduction

## Automatic compression is not appropriate for

- requirements or acceptance criteria
- security findings
- architectural decisions and trade-offs
- exact failure evidence during diagnosis
- file paths, line numbers, test names, scores, or verdicts
- content intended for other people

Never remove evidence required to reproduce, review, or challenge a decision.
Compression must not convert an unavailable, abstained, or inconclusive
decision into `PASS`.

The host may expose this workflow as a skill, command, or orchestration rule.
It must remain opt-in at the host level unless the host has explicit
thresholds and preserves the exclusions above.
