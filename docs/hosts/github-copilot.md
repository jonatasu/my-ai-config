# GitHub Copilot Adapter

Read `../AGENTIC-ENVIRONMENT.md` first, then `agentic.config.yaml`.

Map TARS to the user-facing orchestrator. The active Copilot instruction index
must load the generic architecture document first, then the manifest, then
`docs/hosts/github-copilot.md` and the connector-specific instructions.

Expose the portable skills through Copilot skill bridges, including
`agentic-config`, `generate-feature-map`, and `guardrail-audit`. Use Copilot
skills, hooks, MCP servers, and session state only through explicit host
adapters.

The recommended codebase-context MCP is:

```text
npx -y repomix --mcp --sandbox .
```

Keep it read-only, deny remote-repository packing, and do not persist
credentials.

External mutations, Git staging, commits, pushes, credential access, and
memory writes require approval. Preserve the portable closed-loop and review
contracts.
