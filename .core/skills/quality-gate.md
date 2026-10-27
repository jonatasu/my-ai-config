# Quality Gate Skill

Use this skill before declaring a non-trivial implementation complete.

## Contract

- **Inputs:** Acceptance criteria, current change fingerprint, required checks,
  and independent reviewer.
- **Outputs:** Fresh evidence, check results, review verdict, open findings,
  and `PASS`, `REVIEW`, or `BLOCK`.
- **Failure behavior:** Keep the change incomplete when evidence is stale,
  checks fail, review is negative, or findings remain open.
- **Stop conditions:** Stop only after all required evidence is current and the
  completion decision is supported by the repository state.

## Protocol

1. Translate the requirement into observable acceptance criteria.
2. Capture the repository fingerprint after the final edit.
3. Run the smallest relevant lint, type, test, build, or validation commands.
4. Record concrete evidence for every acceptance criterion.
5. Request an independent review of the current diff.
6. Resolve findings, rerun stale checks, and repeat until no findings remain.
7. Report incomplete or blocked work explicitly.

Checks must be current for the final repository state. A previous passing
result is stale after a relevant edit.
