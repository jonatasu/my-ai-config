# Memory Skill

Use this skill to preserve durable context across tasks and sessions.

## Contract

- **Inputs:** Candidate fact, decision, error, preference, project state, or
  handoff; project scope; and configured memory adapter.
- **Outputs:** Search result, atomic memory record, synchronization status, and
  validation result.
- **Failure behavior:** Report provider or validation failures explicitly and
  never claim persistence when synchronization did not succeed.
- **Stop conditions:** Stop after duplicate search, atomic write,
  synchronization, and validation, or report the exact blocked step.

## Protocol

1. Search existing memory before adding a fact.
2. Store one atomic fact, decision, error, or context item per entry.
3. Include project, topic, source, and concrete tags.
4. Link related entities when the storage system supports it.
5. Never store credentials, tokens, private keys, or unnecessary personal data.
6. Sync the session or handoff state.
7. Validate persistence and report failures explicitly.

The storage adapter may be Markdown, SQL, a vector index, a graph, or another
local system. The workflow must not depend on one vendor.
