# Agent Orchestration & Delegation

This document defines how a primary AI agent (Controller) should orchestrate sub-agents (Specialists) using a **Spec-Driven Development (SDD)** and **Harness-based** workflow.

## 1. The Controller-Specialist Pattern

Instead of attempting to solve everything in a single context, the Controller should decompose tasks and dispatch them to specialized sub-agents.

### Sub-Agent Dispatching

When a task requires deep expertise, the Controller must follow this orchestration protocol:

1.  **Skill Identification**: Consult `.core/skills/index.md` to identify the most appropriate specialist persona for the domain.
2.  **Analyze the Requirement**: Deeply analyze the task to define the "Spec" (the contract of what must be done).
3.  **Dispatch with Context**: Send the sub-agent a focused prompt containing:
    *   The specific sub-task description.
    *   The identified **Spec/Contract**.
    *   Relevant code snippets or file paths.
    *   The architectural context (how this task fits into the bigger picture).
4.  **Review and Integrate**: Evaluate the sub-agent's output against the original **Spec** and the **Harness** validation results.

## 2. Escalation Protocol (The "Stop & Ask" Rule)

Sub-agents must not guess. If an agent encounters ambiguity, it must escalate immediately.

**Mandatory Escalation Triggers:**
- **Spec Ambiguity**: When the requirements/specification are unclear or contradictory.
- **Contract Mismatch**: When the implementation cannot meet the defined contract (Harness failure).
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
