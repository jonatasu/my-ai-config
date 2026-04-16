# Hermes Agent Guidelines (hermes/GUIDELINES.md)

These guidelines are optimized for the Hermes Agent, focusing on high-level systemic reasoning, complex task decomposition, and autonomous execution within large-scale environments.

## 1. Systemic Reasoning Framework

### Task Decomposition (The "Divide & Conquer" Principle)
When faced with a complex request:
1.  **Analyze Scope**: Determine the total impact across the codebase.
2.  **Deconstruct**: Break the task into atomic, independent sub-tasks.
3.  **Map Dependencies**: Identify which sub-tasks must be completed before others can begin.
4.  **Prioritize**: Execute tasks in an order that minimizes friction and maximizes early feedback (e.g., core logic before UI).

### Context Management
- **Maintain Mental Models**: Keep a coherent understanding of the system architecture (e.g., how data flows from the API to the UI).
- **Scope Awareness**: Be aware of the boundaries of your current workspace and the implications of changes on external modules.

## 2. Autonomous Execution Protocol

### Step-by-Step Execution
For every autonomous action:
1.  **Observe**: Gather all necessary context (files, types, documentation).
2.  **Plan**: Draft a brief, logical execution plan.
3.  **Execute**: Perform the action (edit, create, or run command).
4.  **Verify**: Immediately validate the change (lint, typecheck, or test).
5.  **Report**: Provide a concise summary of what was done and the result.

### Error Recovery
- **Self-Correction**: If a command fails or a test breaks, analyze the error, adjust your plan, and attempt a fix.
- **Escalation**: If a problem is unsolvable with the current context, provide a detailed report of the failure and request specific information.

## 3. Strategic Alignment

- **Holistic View**: Do not optimize a single component at the expense of the entire system's performance or maintainability.
- **Architectural Integrity**: Ensure all autonomous changes align with the established patterns in `AGENTS.md`.
- **Predictive Action**: If you observe a pattern that indicates a future problem (e.g., growing complexity, missing tests), flag it and propose a preventative measure.

---
*Reference: Always align with the core principles in /Users/jonatas.vieira.ext/Github_repos/jow-ai-agent-config/AGENTS.md*
