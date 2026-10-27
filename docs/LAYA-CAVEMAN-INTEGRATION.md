# Laya and Caveman Integration

This document defines the shared workflow for hosts that provide both the
Laya decision engine and Caveman compression.

## Roles

### Laya

Laya is a structured decision signal. It evaluates bounded criteria such as
requirement compliance, test evidence, regression risk, and change quality.
It returns `PASS`, `REVIEW`, or `BLOCK`, together with confidence or an
abstention state.

Laya does not replace:

- engineering judgment
- tests
- independent review
- acceptance-criteria validation
- correction of confirmed findings

### Caveman

Caveman reduces internal context and communication overhead. It is useful for
subagent reports, repetitive logs, completed checkpoints, and handoffs.

Caveman is not a quality gate and must not rewrite or summarize away evidence
needed to reproduce or challenge a decision.

## Canonical workflow

```text
collect evidence
  -> run checks
  -> send complete evidence to Laya
  -> inspect Laya's signal manually
  -> correct REVIEW/BLOCK findings
  -> rerun checks and Laya when required
  -> compress internal reports and handoffs
  -> report the result in normal language
```

Compression before Laya is prohibited when it can remove requirements,
acceptance criteria, file and line evidence, test results, confidence, or
open findings.

## Decision policy

Run the gate for non-trivial executable changes, configuration changes,
shared business logic, and pre-PR quality gates. Do not force it for
documentation-only, formatting-only, or comment-only changes.

If Laya is unavailable when required, return `BLOCK`. If Laya abstains or has
confidence below `0.6`, return `REVIEW` and investigate manually. Never turn
an unavailable or inconclusive result into `PASS`.

Use a maximum of two correction attempts in the host controller. The host may
use a lower limit when the task is narrower.

## Host mappings

### CLI

The local Laya executable is:

```text
laya
```

It is suitable for local routing and prediction workflows. Hosts must pass
structured, bounded evidence and must not persist credentials or private
payloads.

### MCP

The local MCP server is:

```text
laya-mcp-server
```

The MCP transport exposes Laya tools to hosts that support local MCP servers.
The host must keep the server local and preserve the same decision policy as
the CLI adapter.

### OpenCode

OpenCode should:

- load the Laya MCP server as an optional local provider;
- expose explicit `laya-check`, `laya-review`, and `laya-pr` workflows;
- keep post-edit behavior as a reminder, not an automatic full review;
- allow the orchestrator to use the Laya CLI when MCP is unavailable;
- block required completion when both Laya transports are unavailable;
- compress only internal evidence after the Laya decision.

### GitHub Copilot CLI

Copilot CLI uses the installed Laya plugin and existing post-edit reminder
hook. The hook should remind the agent to run the appropriate gate; it should
not launch a full review after every edit. The existing Caveman plugin remains
available for explicit or internally selected compression.

## Security and privacy

Do not send secrets, credentials, private keys, customer data, or unnecessary
personal data to Laya. Keep MCP commands local and store no authentication
material in this repository or host configuration.
