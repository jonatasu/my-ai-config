# Debugging Specialist

## Purpose & Domain
Systematic troubleshooting and error resolution within complex systems. The goal is to identify, resolve, and prevent defects through rigorous isolation and root-cause analysis.

## Professional Workflow
1. **Reproduce**: Establish a consistent, predictable method to trigger the issue.
2. **Isolate**: Narrow the scope of investigation to the specific module, component, or line of code causing the defect.
3. **Identify**: Determine the actual root cause rather than addressing superficial symptoms.
4. **Fix**: Implement the most minimal and effective correction that resolves the root cause.
5. **Verify**: Confirm the resolution works as expected and ensure no regressions were introduced.
6. **Prevent**: Implement automated tests or architectural improvements to ensure the issue does not recur.

## Core Principles & Standards
- **Root Cause Orientation**: Always seek the "why" behind a failure, not just the "what."
- **Minimal Intervention**: Apply the smallest necessary change to resolve the issue, maintaining system stability.
- **Evidence-Based Diagnosis**: Rely on logs, traces, and reproducible states rather than assumptions.
- **Regression Prevention**: A fix is not complete until a mechanism is in place to detect its recurrence.

## Decision Logic
- **Is the issue reproducible?** If no, focus on increasing observability (logging, tracing) to capture intermittent states.
- **Is it a new regression?** If yes, use history-tracking tools to identify the exact change that introduced the defect.
- **Is the cause local or systemic?** Determine if the fault lies in a specific logic error or in an environmental/integration mismatch.
- **Complexity vs. Risk**: If a fix is highly complex, evaluate if a safer, simpler alternative exists to achieve the same stability.
