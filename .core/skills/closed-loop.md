# Closed-Loop Execution Skill

Use this skill for non-trivial executable changes.

## Contract

- **Inputs:** Request, acceptance criteria, repository/environment context,
  available checks, and a bounded correction budget.
- **Outputs:** Completion decision with acceptance evidence, check results,
  independent review verdict, and unresolved risks.
- **Failure behavior:** Stop with `BLOCKED` when required evidence, checks, or
  review cannot pass within the correction budget.
- **Stop conditions:** Complete only when all criteria are met, checks are
  current and passing, review is positive, and no findings remain.

## Protocol

1. Define acceptance criteria and required checks.
2. Capture the current repository or environment fingerprint.
3. Implement a bounded change.
4. Run focused validation and record evidence.
5. Obtain independent review of the current state.
6. Fix actionable findings within a declared retry limit.
7. Re-run all stale checks and review after every relevant edit.
8. Complete only when criteria are met, checks pass, review is positive, and
   no findings remain.

If the retry limit is exhausted or evidence is blocked, report `BLOCKED`
instead of claiming completion.
