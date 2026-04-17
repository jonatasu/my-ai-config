# Workflow, Planning & Communication

This document defines how to transform requirements into execution and how to communicate progress professionally.

## 1. Task Decomposition & Planning

### The Planning Phase
Before touching any code, a comprehensive implementation plan must be created.

**A good plan must include:**
- **Goal**: A single sentence describing the objective.
- **Architecture**: A brief summary of the approach (e.g., "New composable for auth").
- **File Mapping**: A list of files to be created or modified with their specific responsibilities.
- **Bite-Sized Tasks**: Decomposition into atomic steps (2-5 minutes each) following a TDD cycle:
    1. Write a failing test.
    2. Run/verify failure.
    3. Implement minimal code.
    4. Run/verify success.
    5. Commit.

### Execution Options
After presenting a plan, the agent must offer the user two execution paths:
1.  **Subagent-Driven (Recommended)**: Dispatching a fresh sub-agent per task with a review between tasks. High reliability and iteration.
2.  **Inline Execution**: Executing tasks sequentially in the current session with checkpoints. Faster, but higher risk of context drift.

## 2. Professional Communication

### Commit Conventions
All commits must follow the **Conventional Commits** specification in English:
- **Format**: `<type>(<scope>): <description>`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`.
- **Mood**: Use the imperative mood (e.g., `feat: add login`, not `added login`).

### Branch Naming
Follow the pattern: `<type>/<ticket-id>-<short-description>` (e.g., `feature/AUTH-123-oauth-login`).

### Language Rules
- **Code/Commits/Docs**: English.
- **Comments**: English (avoid unless absolutely necessary).
- **Branch Names**: English.

## 3. Tooling (MCP) Usage

When Model Context Protocol (MCP) tools are available, follow these principles:

- **Specificity**: Use the most specialized tool for the job (e.g., `context7` for docs, `firecrawl` for scraping).
- **Atomicity**: Design tools to perform single, focused actions.
- **Structured Output**: Tools should support both JSON (for programmatic use) and Markdown (for human readability).
- **Pagination**: Always implement and respect `limit` and `offset/cursor` parameters for listing resources.
