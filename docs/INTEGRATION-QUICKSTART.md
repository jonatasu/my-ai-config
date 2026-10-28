# Five-Minute Host Integration

This repository is a portable configuration source. It is not an application
that an AI host must launch. The host reads the manifest and maps its own
instruction, tool, memory, approval, and verification mechanisms to the
portable contracts.

## 1. Read the vendor-neutral architecture

Read [`AGENTIC-ENVIRONMENT.md`](./AGENTIC-ENVIRONMENT.md) first. It defines
the portable loading model, TARS ownership, capability boundaries, safety
rules, and verification expectations.

## 2. Load the manifest

Read [`../agentic.config.yaml`](../agentic.config.yaml) from the repository
root. Resolve every relative path from that root.

## 3. Load the portable core

Load the files in this order:

1. System prompt
2. Mindset
3. Engineering and quality principles
4. Skill index
5. Agent registry
6. Tool catalog
7. Orchestration and workflow rules
8. Memory contract
9. Permission policy
10. Verification policy

Provider and host adapters are optional. Load them only after the portable core
is available.

## 4. Map host capabilities

Select a template from [`../adapters/hosts/`](../adapters/hosts/):

- `cli.yaml` for terminal agents
- `ide.yaml` for editor-integrated agents
- `api.yaml` for service agents
- `mcp.yaml` for MCP-capable agents

Map each host capability to the contracts in the manifest. If a capability is
missing, declare it unavailable instead of silently simulating it.

## 5. Apply safety and verification

Enforce [`../policies/permissions.yaml`](../policies/permissions.yaml) before
enabling tools. In particular:

- never persist secrets
- require approval for writes and external mutations
- deny destructive actions by default
- surface authorization failures

Use [`../verification/default.yaml`](../verification/default.yaml) as the
completion baseline. A task is not complete without current evidence and an
independent review when the task is non-trivial.

## 6. Connect memory

Implement the contract in
[`../.core/skills/memory.md`](../.core/skills/memory.md) with the host's
available backend. Markdown, SQL, vector, graph, and hosted stores are valid
adapters. The repository contains the contract, not conversation history.
Search before adding durable memory and never store credentials.

## 7. Configure independent review

Map [`../adapters/review/README.md`](../adapters/review/README.md) to the
host's reviewer or review service. A missing, silent, or stale reviewer must
produce an inconclusive result rather than a false `PASS`.

## 8. Run the conformance check

From the repository root:

```bash
python3 tests/test_configuration_consistency.py
```

The check verifies manifest references, required policy controls, adapter
templates, and the portable configuration structure.

## OpenCode host mapping

For OpenCode, use the host adapter at
[`../adapters/hosts/opencode.yaml`](../adapters/hosts/opencode.yaml). The
global configuration should load the manifest, registry, tool catalog,
portable policies, and verification contracts. Keep provider-specific MCP
servers disabled unless their permissions and approval boundaries are
configured explicitly.

For the complete Grill, Laya, and Caveman lifecycle, see
[`GRILL-LAYA-CAVEMAN-WORKFLOW.md`](GRILL-LAYA-CAVEMAN-WORKFLOW.md). For the
provider-specific Laya and Caveman integration, see
[`LAYA-CAVEMAN-INTEGRATION.md`](LAYA-CAVEMAN-INTEGRATION.md). The required
ordering is Grill when the decision is consequential, implementation and
checks, then Laya, then internal Caveman compression. Do not compress evidence
before Laya evaluates it, and keep final user-facing output in normal language.

The current OpenCode setup also enables two optional MCPs:

- **Context7** for current, versioned library and framework documentation.
- **Playwright** for browser automation and UI verification.
- **Firecrawl** for web scraping, crawling, and structured web research.

Context7 is remote and may require host-managed authentication. Playwright is
local through `npx` and keeps unrestricted file access disabled. Keep these
servers enabled only when the task benefits from them because MCP tool schemas
consume context. Firecrawl is local through `npx` and reads
`FIRECRAWL_API_KEY` from the host environment through OpenCode's
`{env:FIRECRAWL_API_KEY}` substitution. Never place the key in this repository,
`opencode.jsonc`, shell history, or session exports. Because the key was shared
in chat, rotate it if it is still active, then provide the replacement through a
secure local environment or keychain-backed wrapper.

## Conversation history migration

OpenCode supports its own session export and import formats, but it does not
provide a native importer for GitHub Copilot CLI session databases or event
streams. A complete migration therefore requires a deliberate transformation:

1. Export Copilot sessions to a neutral, redacted JSON or Markdown archive.
2. Preserve timestamps, roles, text, tool calls, repository paths, and
   checkpoint references where available.
3. Convert each selected archive into OpenCode's session import format.
4. Import and verify the sessions in a disposable OpenCode workspace.

Do not migrate every session blindly. Copilot histories may contain secrets,
private source, customer data, tool arguments, or stale environment paths.
The safer default is to migrate selected sessions or summarized durable context
into the configured memory adapter, while retaining the original Copilot
databases as read-only source archives.
