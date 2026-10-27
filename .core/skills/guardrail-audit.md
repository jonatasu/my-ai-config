# Guardrail Audit and Enforcement

Audit a project to distinguish soft rules from mechanically enforced
guardrails. Identify agent-generated anti-patterns that bypass current checks,
then produce exact lint, compiler, test, architecture, and CI changes to block
them.

Evaluate:

- banned anti-patterns and APIs
- directory and import boundaries
- simplest safe architectural paths
- strict CI pull-request blocking
- recurring review findings converted into static rules

First produce an evidence-linked audit. Apply repository changes only after
approval or explicit execution mode. Verify every new guardrail with a
positive and negative fixture.
