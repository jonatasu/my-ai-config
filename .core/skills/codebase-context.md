# Codebase Context

Use a bounded, read-only codebase context provider for large repositories.
Prefer selective packaging and incremental retrieval over sending the entire
repository to a model.

When Repomix is available, use its sandboxed MCP server. Keep repository
configuration and remote packing disabled for untrusted sources unless the
operator explicitly approves them.
