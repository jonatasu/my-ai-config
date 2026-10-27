# Adapter Boundary

Adapters connect the portable agentic contracts to a specific host, provider,
tool transport, memory backend, or organization.

The portable core must remain useful when every adapter is removed.

## Adapter categories

- `hosts/`: templates for CLI, IDE, API, or MCP host integrations.
- `memory/`: examples of Markdown, SQL, vector, graph, or hosted memory backends.
- `review/`: independent-review provider contracts and implementations.
- `tools/`: provider-neutral tool wiring and capability mappings.
- `providers/`: optional model, MCP, plugin, or platform integrations.

Adapters may contain provider names, URLs, package commands, and environment
variables. Do not copy those details into `.core/`, `agentic.config.yaml`,
or the portable policy files.

The Laya/Caveman provider adapter is documented in
`providers/laya-caveman.yaml`. Laya is the decision signal. Caveman is an
evidence-preserving internal compression stage that runs only after the
decision input and required checks are complete.

The existing `.tools/mcp_setup/` directory is an optional provider example.
It is not required by the portable core.
