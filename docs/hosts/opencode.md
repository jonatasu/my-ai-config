# OpenCode Adapter

Read `../AGENTIC-ENVIRONMENT.md` first, then `agentic.config.yaml`.

OpenCode maps TARS to the primary user-facing agent and uses focused subagents
for review, validation, Laya decisions, and Systems of Work connectors.

Configured optional MCPs include Laya, Context7, Playwright, Firecrawl, and
Repomix. Repomix must run with `--mcp --sandbox .` and remain read-only.

OpenCode permissions must require approval for edits, shell commands, external
directories, subagents, Git staging, and Git commits.
