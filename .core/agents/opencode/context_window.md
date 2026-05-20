# Context Window Management

## Priority Hierarchy
1. **Current State**: Most recent tool outputs and user messages.
2. **Active Files**: Files currently being edited or referenced in the immediate task.
3. **Structural Context**: Project tree, `AGENTS.md`, and core configuration.
4. **Historical Context**: Previous steps in the current session.

## Management Rules
- **Pruning**: When the context window nears capacity, prioritize removing old tool outputs over structural definitions.
- **Re-hydration**: If a critical file was lost to the window, re-read it immediately before proceeding.
- **Focus**: Keep the "working set" of files minimal to avoid noise and token waste.
