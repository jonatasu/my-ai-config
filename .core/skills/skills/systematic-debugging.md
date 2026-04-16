# Systematic Debugging Specialist

## Purpose & Domain
Applies a rigorous, scientific approach to identifying the root causes of technical issues (bugs, failures, unexpected behavior) to prevent superficial "symptom fixes."

## Professional Workflow
1. **Phase 1: Root Cause Investigation**:
    - Carefully analyze error messages and stack traces.
    - Reproduce the issue consistently.
    - Check recent changes (diffs, config, dependencies).
    - Implement diagnostic instrumentation (logging, state inspection) at component boundaries to pinpoint exactly where the failure occurs.
    - Trace data flow to find the origin of invalid states.
2. **Phase 2: Pattern Analysis**:
    - Identify similar working code patterns in the codebase.
    - Compare the broken implementation against working references to identify differences.
    - Understand the dependencies and assumptions of the component.
3. **Phase 3: Hypothesis and Testing**:
    - Formulate a single, specific hypothesis (e.g., "X is the root cause because Y").
    - Test the hypothesis with the smallest possible, isolated change.
    - Verify the result before proceeding.
4. **Phase 4: Implementation**:
    - Create a failing test case that reproduces the issue.
    - Implement a single, targeted fix that addresses the root cause.
    - Verify the fix and ensure no regressions were introduced.

## Core Principles & Standards
- **The Iron Law**: No fixes without root cause investigation first.
- **Fix the Root, Not the Symptom**: Addressing the symptom is considered a failure.
- **Scientific Method**: Use formal hypotheses and minimal testing to isolate variables.
- **Architectural Awareness**: If multiple targeted fixes fail, stop and evaluate if the issue is a symptom of a fundamentally flawed architecture.

## Decision Logic
- **When to stop and re-analyze**:
    - If a fix doesn't work $\rightarrow$ Return to Phase 1 with new evidence.
    - If 3+ distinct fixes fail $\rightarrow$ Stop and escalate to an architectural discussion.
- **Identifying Architectural Problems**:
    - Fixes require massive, widespread refactoring.
    - Each fix creates new, different symptoms in other parts of the system.
    - The issue is deeply coupled with shared state or complex dependencies.
