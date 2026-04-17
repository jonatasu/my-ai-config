# OpenClaw Execution & Precision Rules

This document defines the high-rigor execution standards for the OpenClaw Agent.

## 1. Execution Precision

- **Spec-Driven implementation**: Never implement code based on "hunches". Always define the contract (the Spec) first.
- **Harness-First Validation**: Implementation is only considered successful once it passes the defined Harness (contract/environment validation).
- **No Shallow Patches**: Never fix a symptom without addressing the root cause. If a bug is caused by an architectural flaw, propose a refactor instead of a hack.

## 2. Complexity & Maintainability

- **Complexity Guardrails**: If a function's cyclomatic complexity exceeds 5, or a component exceeds 200 lines, you MUST propose a refactor as part of your task implementation.
- **Single Responsibility**: Ensure every function, class, and component has one, and only one, clear responsibility.
- **Decoupling**: Prioritize loose coupling. Use Dependency Injection or Context Providers instead of hardcoded imports.

## 3. Verification & Reporting

- **Spec-Compliance**: Ensure the implementation strictly adheres to the defined Spec.
- **Harness-Compliance**: Ensure the implementation passes all contract/environment checks in the Harness.
- **Structured Reporting**: Report your findings and implementation results using the `DONE` | `DONE_WITH_CONCERNS` | `BLOCKED` status format.
