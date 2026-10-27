# Memory Adapter Boundary

The portable core defines memory behavior in `.core/skills/memory.md`.

This repository stores the memory contract and adapter documentation, not
conversation history or durable memory entries. Implement one adapter here
when the host needs durable storage. Supported backend shapes include
Markdown, SQL, vector, graph, or hosted services.

Adapters must provide search, append-only writes, privacy controls, and an
explicit failure result. Never store secrets or unnecessary personal data.
