# Portable Agentic Environment

This document defines how to transform a normal AI configuration into an
agentic environment that can reason, act, remember, verify, and improve across
projects and AI platforms.

The design is vendor-neutral. A host may be a CLI, IDE, API service, desktop
application, or custom runtime. Provider-specific features belong in adapters,
not in the portable core.

The repository-level entrypoint for discovery is `agentic.config.yaml`. The
vendor-neutral `AGENTIC-ENVIRONMENT.md` contract is the first document to read.
Hosts then resolve the referenced contracts and optional host adapters.

## 1. What Makes an Environment Agentic?

An AI environment becomes agentic when it can complete a bounded loop:

```text
intent
  -> context discovery
  -> plan and decision
  -> tool action
  -> observation
  -> verification
  -> memory or handoff
```

Conversation alone is not enough. The environment must expose capabilities and
state transitions that make progress observable and recoverable.

## 2. Portable Architecture

### Cognitive layer

- **Mindset:** behavior, communication, safety, and decision rules.
- **Principles:** engineering, architecture, security, reliability, and
  maintainability constraints.
- **Skills:** reusable procedures with explicit triggers, inputs, outputs, and
  stop conditions.
- **Agent roles:** TARS as the sole orchestrator plus optional specializations
  such as planner, implementer, reviewer, researcher, or connector operator.

### Operational layer

- **Tools:** narrow actions against files, repositories, APIs, browsers,
  runtimes, and external systems.
- **Orchestration:** routes work between skills, tools, agents, and humans.
- **State:** tracks tasks, dependencies, checkpoints, findings, and decisions.
- **Verification:** runs tests and evaluates acceptance criteria against the
  current environment state.

### Persistence layer

- **Working memory:** current request, plan, files, and tool results.
- **Episodic memory:** completed tasks, failures, and lessons learned.
- **Semantic memory:** reusable facts, patterns, and decisions.
- **Handoff state:** enough context for another agent or later session to
  continue safely.

## 3. Minimum Contracts

Every portable implementation should define these contracts:

### Skill contract

```text
name
purpose
triggers
inputs
steps
outputs
failure behavior
stop conditions
```

Skills should be composable and should not assume a specific model, editor, or
tool transport.

### Tool contract

```text
name
purpose
typed inputs
structured output
side effects
failure states
authorization requirements
```

Tools must be narrow, explicit, bounded, and safe by default.

### Agent contract

```text
role
scope
required context
allowed tools
deliverable
escalation conditions
review expectations
```

An agent is a role with constraints, not merely a personality prompt.

### State contract

At minimum, persist:

- task identifier and objective
- acceptance criteria
- current phase and owner
- dependencies and blockers
- changed resources
- check results and timestamps
- review findings and resolutions
- decisions and handoff context

### Orchestration ownership

TARS is the only orchestration role. It owns decomposition, delegation,
approval gates, queue draining, verification coordination, escalation, and the
final user-facing result. Specialist agents execute bounded work and do not
become competing orchestrators.

## 4. Core Portable Skills

### Decision gate

Use a decision gate to evaluate a narrow question against explicit criteria.
The result should be `PASS`, `REVIEW`, or `BLOCK`, with confidence and evidence.

Provider-specific engines such as Laya may implement this contract. They are
signals, not substitutes for human or independent engineering judgment.

### Grilling

Use adversarial questioning before committing to a plan, architecture, or
high-risk decision. Challenge:

- unclear goals and unstated assumptions
- scope, dependencies, and non-goals
- failure modes and rollback paths
- security, privacy, and authorization boundaries
- testability, observability, and operational cost
- long-term maintenance and migration impact

Grilling must produce decisions or open questions, not endless criticism.

### Closed-loop execution

For non-trivial changes:

1. Define acceptance criteria.
2. Establish the current state and fingerprint.
3. Implement the smallest complete change.
4. Run focused checks.
5. Obtain independent review.
6. Correct findings within a bounded retry budget.
7. Re-run stale checks and review.
8. Complete only when evidence is current and no findings remain.

### Memory

Persist only durable, useful facts. Search before adding. Store one atomic fact
per memory and never persist secrets, credentials, or unnecessary personal
data. Support local adapters such as Markdown, SQL, vector stores, or graph
databases without coupling the core workflow to one implementation.

## 5. Lifecycle

### Discover

Read the request, repository guidance, relevant memory, and available tools.
Separate facts, assumptions, constraints, and unknowns.

### Decide

Select the minimum required skills and tools. Grill ambiguous or high-risk
decisions. Define acceptance criteria before editing.

### Plan

Map the requirement to files, boundaries, dependencies, checks, and rollback.
Prefer direct execution for small work and isolated agents for substantial
independent work.

### Act

Use narrow tools. Keep changes small. Surface errors explicitly. Avoid
silent fallbacks and speculative abstractions.

### Verify

Run repository-native checks. Validate the requirement itself, not a proxy.
Record commands, results, and known limitations.

### Learn

Record decisions, reusable patterns, errors, and handoff context. Do not store
secrets. Keep local adapters and provider details outside the portable core.

## 6. Portability Boundary

Portable core:

- principles, contracts, workflows, schemas, and decision rules
- provider-neutral skill and agent descriptions
- generic tool safety and verification guidance

Local adapter:

- model names and provider APIs
- MCP or plugin configuration
- credentials and secret stores
- organization names, internal URLs, repositories, and identities
- platform-specific commands and deployment systems

Adapters may implement the portable contracts, but the core must remain useful
when every adapter is replaced.

## 7. Readiness Checklist

- [ ] The environment can discover context before acting.
- [ ] Skills have explicit inputs, outputs, and stop conditions.
- [ ] Tools have typed boundaries and structured failures.
- [ ] Agents have roles, scopes, and escalation rules.
- [ ] Plans include acceptance criteria and dependencies.
- [ ] High-risk decisions can be grilled before implementation.
- [ ] Checks and review evidence are recorded against the current state.
- [ ] Memory is searchable, atomic, and secret-free.
- [ ] A handoff can resume work without hidden context.
- [ ] Provider-specific behavior is isolated behind adapters.
- [ ] A manifest identifies the core, capabilities, policies, adapters, and
  loading order.
- [ ] Permission policy distinguishes inspection, execution, writing, network
  access, memory writes, and destructive actions.
- [ ] Verification defaults are configurable per host and repository.
