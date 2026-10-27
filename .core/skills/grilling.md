# Grilling Skill

Use this skill to stress-test plans, architecture, requirements, and risky
decisions before implementation.

## Contract

- **Inputs:** Decision or plan, assumptions, constraints, affected systems,
  evidence, and decision deadline.
- **Outputs:** Ranked questions, exposed risks, required mitigations, and an
  executable recommendation.
- **Failure behavior:** Return `REVIEW` when evidence is insufficient; never
  invent facts or force a decision.
- **Stop conditions:** Stop when material assumptions are tested and remaining
  uncertainty is explicit and accepted.

## Protocol

1. Restate the decision and desired outcome.
2. Identify assumptions, unknowns, constraints, and non-goals.
3. Challenge scope, dependencies, failure modes, security, testing,
   observability, rollback, and maintenance cost.
4. Ask the smallest set of questions that can change the decision.
5. Classify each answer as a decision, action, risk, or open question.
6. Stop when the decision is clear enough to execute.

Do not use grilling to create artificial uncertainty or to delay low-risk work.
