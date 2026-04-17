# OpenClaw Agent Guidelines (openclaw/GUIDELINES.md)

These guidelines are optimized for the OpenClaw Agent, focusing on deep-code analysis, autonomous execution, and heavy-duty engineering tasks.

## 1. Analytical Reasoning Framework
### Deep-Dive Analysis
When tasked with understanding a codebase or a complex bug:
1.  **Trace the Flow**: Don't just look at the function; follow the data from source to sink.
2.  **Map Dependencies**: Identify what will break if this code is changed.
3.  **Identify Patterns**: Recognize existing architectural patterns to ensure consistency.

### Context Awareness
- **Holistic View**: Always consider how your changes impact the entire system, not just the local file.
- **Dependency Management**: Be aware of the versions and implications of all imported modules.

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

## 3. Engineering Excellence
- **Robustness**: Write code that handles edge cases and failure modes gracefully.
- **Complexity Control**: Maintain low cyclomatic complexity and small, single-purpose functions.
- **Documentation**: Every significant change must be accompanied by updated documentation and clear commit messages.
---
*Reference: Always align with the core principles in /Users/jonatas.vieira.ext/Github_repos/my-ai-config/.core/mindset/AGENTS.md*
