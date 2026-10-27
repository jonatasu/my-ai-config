# Session Lifecycle

Use explicit lifecycle checkpoints for long or interruptible work.

## Pause

Stop at a safe boundary, preserve the current state, record completed and
pending work, evidence, open gates, and the first resume action. Do not claim
completion.

## Resume

Read the checkpoint first. Verify inherited claims against the current
repository before continuing. Do not blindly replay completed work.

## Handoff

Include the objective, repository fingerprint, changed paths, decisions,
verification results, unresolved findings, and exact next command.
