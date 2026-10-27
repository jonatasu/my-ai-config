# Feature Validation Skill

Use this skill to convert a feature request into observable acceptance criteria
and verify the complete behavior before declaring the work complete.

## Contract

- **Inputs:** Feature request, constraints, affected surfaces, and available
  validation capabilities.
- **Outputs:** Acceptance criteria, validation cases, current evidence, and an
  explicit `PASS`, `REVIEW`, or `BLOCKED` result.
- **Failure behavior:** Report unmet criteria, missing evidence, or unavailable
  capabilities. Never treat a plausible implementation as validated.
- **Stop conditions:** Stop after every criterion has current evidence or the
  result is explicitly blocked.

## Protocol

1. Identify the user-visible behavior and affected interfaces.
2. Write criteria that are observable and independently verifiable.
3. Cover the normal path, boundary cases, failure behavior, and compatibility
   expectations.
4. Map each criterion to the smallest meaningful check.
5. Run checks against the current repository or environment fingerprint.
6. Record outputs, exit codes, and unresolved risks.
7. Return `PASS` only when all required criteria have current evidence.

## Validation Record

Each feature validation record should include:

- feature identifier and scope
- acceptance criteria
- check command or manual procedure
- expected and actual result
- repository or environment fingerprint
- reviewer or approver
- unresolved findings and follow-up ownership

Feature validation complements, but does not replace, testing, security review,
independent code review, or the closed-loop engineering process.
