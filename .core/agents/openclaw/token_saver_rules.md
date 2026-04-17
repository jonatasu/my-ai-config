# OpenClaw Execution & Precision Rules

This document defines the high-rigor execution standards for the OpenClaw Agent.

## 1. Execution Precision

- **No Shallow Patches**: Never fix a symptom without addressing the root cause. If a bug is caused by an architectural flaw, propose a refactor instead of a hack.
- **Strict Dependency Management**: Always verify that new dependencies are necessary and follow the project's package management patterns.
- **Type Integrity**: Every new variable, property, or function must be strictly typed. No `any`, no implicit types.

## 2. Complexity & Maintainability

- **Complexity Guardrails**: If a function's cyclomatic complexity exceeds 5, or a component exceeds 200 lines, you MUST propose a refactor as part of your task implementation.
- **Single Responsibility**: Ensure every function, class, and component has one, and only one, clear responsibility.
- **Decoupling**: Prioritize loose coupling. Use Dependency Injection or Context Providers instead of hardcoded imports where possible.

## 3. Verification & Reporting

- **Test-First Mentality**: Never consider a task "done" until you have written and passed the necessary tests.
- **Rigorous Self-Review**: After implementation, perform a "mental linting" pass:
    - Did I follow the established patterns?
    - Did I introduce any side effects?
    - Is the code as simple as it can possibly be?
- **Structured Reporting**: Report your findings and implementation results using the `DONE` | `DONE_WITH_CONCERNS` | `BLOCKED` status format.
