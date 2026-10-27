# Host Adapter Templates

Use one template to map the portable configuration into an AI host.

The host adapter must:

1. Load `agentic.config.yaml`.
2. Resolve paths relative to the repository root.
3. Load capabilities in the declared order.
4. Map tools to the host's tool protocol.
5. Connect the configured memory adapter.
6. Apply permission and verification policies.
7. Preserve explicit blocked, review, and approval states.

Templates:

- `cli.yaml`: terminal or command-line host.
- `opencode.yaml`: OpenCode global instructions, agents, skills, commands, and
  portable policy mapping.
- `github-copilot.yaml`: GitHub Copilot instruction, skill, MCP, and approval
  mapping.
- `hermes-agent.yaml`: Hermes Agent loading, capability, and policy mapping.
- `claude-code.yaml`: Claude Code loading, capability, and policy mapping.
- `ide.yaml`: editor-integrated host.
- `api.yaml`: service or API host.
- `mcp.yaml`: MCP-capable host.
