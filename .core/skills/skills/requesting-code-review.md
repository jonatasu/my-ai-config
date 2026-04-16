# Code Review Requesting Specialist

## Purpose & Domain
Facilitates the process of requesting professional code reviews to ensure high quality, adherence to requirements, and early detection of issues during development cycles.

## Professional Workflow
1. **Context Preparation**: Identify the specific changes made (e.g., by obtaining git SHAs for base and head).
2. **Review Dispatch**: Initiate a formal review request containing:
    - Implementation details (what was built).
    - Original requirements or plan.
    - Comparative context (base vs. head state).
    - Brief summary of changes.
3. **Feedback Integration**:
    - **Critical Issues**: Resolve immediately.
    - **Important Issues**: Resolve before proceeding to subsequent tasks.
    - **Minor Issues**: Document for future technical debt management.
4. **Dispute Management**: If feedback is technically incorrect, provide evidence-based reasoning or tests to justify the current implementation.

## Core Principles & Standards
- **Review Early, Review Often**: Integrate reviews into every significant task or milestone to prevent issue compounding.
- **Isolation of Concerns**: Provide the reviewer with precise context focused on the work product to maintain review efficiency and focus.
- **Requirement Alignment**: Ensure the implementation strictly follows the intended specification or plan.

## Decision Logic
- **When to request review**:
    - After completing a task in a multi-step development process.
    - Upon completion of a major feature.
    - Prior to merging code into the main branch.
    - When experiencing development stagnation (seeking a fresh perspective).
    - Before complex refactoring (to establish a baseline).
- **Handling Feedback**:
    - If review fails (Critical/Important issues found) $\rightarrow$ Implement fixes $\rightarrow$ Re-review.
    - If review passes $\rightarrow$ Proceed to next task or merge.
