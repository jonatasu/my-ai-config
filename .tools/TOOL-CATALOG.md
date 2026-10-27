# Portable Tooling Catalog

This catalog describes capabilities that can be used across projects. It is
intentionally independent of a specific AI vendor, editor, repository host,
cloud provider, or organization.

## Capability Groups

| Capability | Purpose | Typical implementation |
|---|---|---|
| File and repository inspection | Locate code, read context, inspect history and diffs | `find`, `rg`, file viewers, Git |
| Patch and change application | Make small, reviewable edits | Patch application or editor integration |
| Verification | Run focused tests, linters, type checks, and builds | Project-provided commands |
| Code review | Independently inspect changes for correctness and regressions | Separate reviewer or review pass |
| Documentation research | Fetch authoritative library and platform references | Documentation indexer or web client |
| Agent delegation | Isolate large investigations or specialist work | Sub-agent runner |
| Structured memory | Persist decisions, facts, and lessons without secrets | Markdown vault or database |
| Quality gates | Enforce acceptance criteria and fresh checks | Task controller or CI workflow |
| Web extraction | Retrieve public web content when no structured source exists | Approved scraper or browser tool |
| API testing | Execute collections and validate contracts | API test runner |

## Tool Design Rules

- Prefer the narrowest tool that fully satisfies the operation.
- Keep tool inputs explicit, typed, and validated.
- Return structured results with clear failure states.
- Support bounded output and pagination for collection operations.
- Do not hide destructive actions behind generic names.
- Never persist credentials, tokens, private keys, or sensitive payloads.
- Keep platform-specific adapters at the boundary so the core workflow remains
  portable.

## Capability Selection

1. Inspect before editing.
2. Use existing repository tooling before adding dependencies.
3. Run independent reads or checks in parallel when safe.
4. Use a specialist or isolated context only when the work is too large for a
   direct, bounded investigation.
5. Record evidence for acceptance criteria and review conclusions.

## Excluded from the Portable Core

Organization-specific connectors, repositories, tenant names, internal URLs,
personal identities, and proprietary workflow rules belong in local adapter
configuration. They must not be copied into this catalog or into the core
principles.
