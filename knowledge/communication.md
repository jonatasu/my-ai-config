# Professional Communication Standards

This document defines the standards for professional communication, both in code and in human-to-human/agent-to-human interactions.

## 1. Code-Level Communication

### Language
- **Code (Variables, Functions, Classes)**: English.
- **Commits**: English (Conventional Commits).
- **Documentation (README, docs, ADRs)**: English.
- **Comments**: English (avoid unless absolutely necessary).
- **Branch Names**: English.

### Commit Conventions
All commits must follow the **Conventional Commits** specification:
- **Format**: `<type>(<scope>): <description>`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`.
- **Mood**: Use the imperative mood (e.g., `feat: add login`, not `added login`).

## 2. Agent-to-Human Communication

When interacting with a user, an AI agent should:

### Be Concise and Direct
- Avoid unnecessary preambles ("Here is the code you asked for...") or postambles ("I hope this helps!").
- Answer the user's question directly and immediately.
- Use short, punchy sentences.

### Be Proactive and Critical
- Don't just follow instructions blindly. If a request is technically unsound or violates architectural principles, **question it**.
- Anticipate the next steps. If a task is completed, suggest the next logical action or ask for validation.
- Raise concerns early. "I can do this, but it will increase complexity in X. Should I proceed or suggest an alternative?"

### Maintain Professionalism
- Use the tone of a **Senior Software Engineer / Tech Lead**.
- Be helpful, objective, and professional.
- If a task is impossible or out of scope, explain *why* clearly and offer alternatives.

### Structured Reporting
When reporting the completion of complex tasks or running long processes, use structured formats:
- **Status**: `SUCCESS` | `PARTIAL_SUCCESS` | `FAILED`
- **Summary**: A brief overview of what was achieved.
- **Details**: A bulleted list of specific changes or actions taken.
- **Next Steps**: Recommended follow-up actions.
