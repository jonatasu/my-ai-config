# Agent Orchestration & Delegation

This document defines how a primary AI agent (Controller) should orchestrate sub-agents (Specialists) to handle complex, multi-step tasks.

## 1. The Controller-Specialist Pattern

Instead of attempting to solve everything in a single context, the Controller should decompose tasks and dispatch them to specialized sub-agents.

### Sub-Agent Dispatching
When a task requires deep expertise (e.g., Security, UX, Performance), the Controller must:
1.  **Analyze the Requirement**: Identify the specific domain of expertise needed.
2.  **Dispatch with Context**: Send the sub-agent a focused prompt containing:
    *   The specific sub-task description.
    *   Relevant code snippets or file paths.
    *   The architectural context (how this task fits into the bigger picture).
3.  **Review and Integrate**: Evaluate the sub-agent's output against the original goal before proceeding.

## 2. Escalation Protocol (The "Stop & Ask" Rule)

Sub-agents must not guess. If an agent encounters ambiguity, it must escalate immediately.

**Mandatory Escalation Triggers:**
- **Architectural Ambiguity**: When a task requires a decision with multiple valid approaches.
- **Contextual Blindness**: When the agent needs to understand code beyond the provided scope and cannot find clarity.
- **Uncertainty**: When the agent is unsure if its approach aligns with the codebase's established patterns.
- **Scope Creep**: When a task requires restructuring code in ways the original plan did not anticipate.

**Escalation Reporting Format:**
- **Status**: `BLOCKED` | `NEEDS_CONTEXT`
- **Issue**: Clear description of what is unknown or ambiguous.
- **Attempted Actions**: What the agent tried to do to resolve the issue.
- **Requirement**: Specific information needed to move forward.

## 3. Self-Review Checklist

Every sub-agent must perform a self-review before reporting completion:

- [ ] **Completeness**: Did I fully implement all requirements in the spec?
- [ ] **Quality**: Is the code clean, maintainable, and following established patterns?
- [ ] **Discipline**: Did I avoid overbuilding (YAGNI)?
- [ ] **Testing**: Do tests verify behavior rather than just mocking success?
- [ ] **Error Handling**: Are edge cases and failures handled gracefully?
