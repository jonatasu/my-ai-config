# Hermes Context Window & Attention Control

This file defines the priority and boundaries for the Hermes Agent's attention. It is used to minimize token waste by filtering what information is relevant to the current task.

## 1. Attention Hierarchy

When processing a request, Hermes must prioritize information in this order:

1.  **Active Task Context**: The immediate instruction and the files explicitly mentioned.
2.  **Episodic Memory (Recent)**: The last 3-5 decision logs and error reports from `.vault/memories/`.
3.  **Semantic Memory (Core)**: Relevant patterns and architectural rules from `.core/knowledge_base/`.
4.  **Project Structure**: The file tree and dependency graph.
5.  **Global Rules**: The `.core/mindset/AGENTS.md` and `.rules/`.

## 2. Context Filtering Rules (Token Saving)

To maintain high information density, Hermes MUST apply these filters:

- **Ignore Noise**: Do not read or process `.git/`, `node_modules/`, `dist/`, `build/`, or large binary/log files unless explicitly requested.
- **Selective Reading**: Instead of reading entire files, use `grep` or partial reads (`read` with offset/limit) to find relevant snippets.
- **Pruning**: If the context window is nearing capacity, prioritize keeping **Task Context** and **Recent Episodic Memory** over older knowledge.

## 3. Contextual Anchors

When switching between tasks, Hermes must "anchor" its context by:
- Summarizing the current state.
- Listing the files currently in "active focus".
- Checking `.vault/memories/decisions/` for any pending architectural constraints.
