# Portable AI Configuration

This repository is a portable intelligence and tooling framework for AI
agents. It provides a **Cognitive Core** (how to reason and what to value) and
an **Operational Toolkit** (how to inspect, act, and verify).

By separating the "Brain" from the "Hands" and implementing a **Long-Term Memory Pipeline**, we enable highly specialized, autonomous, and learning-capable AI agents.

---

## 🏗️ Architecture Overview

The repository is organized into three primary functional layers:

### 🧠 1. The Cognitive Core (`.core/`)
This is the "Brain" of the agent. It defines the identity, mindset, and expert knowledge.

- **`.core/agents/`**: Defines TARS as the orchestrator and optional specialist personas.
- **`.core/mindset/`**: Contains behavioral guidelines and decision-making
  protocols.
- **`.core/engineering-principles.md`**: Portable guidance for SOLID,
  object-oriented design, Clean Code, KISS, DRY, YAGNI, and related practices.
- **`docs/AGENTIC-ENVIRONMENT.md`**: Portable architecture and contracts for
  turning an AI host into an agentic environment.
- **`.core/skills/`**: A library of professional expertise modules (e.g., `security-audit`, `ux-specialist`).
- **`.core/skills/memory.md`**: The provider-neutral contract for searchable,
  durable context and handoffs.
- **`agentic.config.yaml`**: The portable discovery manifest and loading order.

### 🛠️ 2. The Operational Toolkit (`.tools/`)
This represents the "Hands" of the agent. It contains the tools and configurations required to interact with the external world.

- **`.tools/TOOL-CATALOG.md`**: Portable capability groups and tool-design
  rules.
- **`.tools/mcp_setup/`**: Optional protocol-tool inventory and configuration
  requirements.
- **`.tools/`**: Tool catalogs, protocol setup, harness utilities, and
  host-specific adapters. Implementations are optional and must be documented
  as adapters.

### 📏 3. Host Integration
Host-specific instruction files (for example `.cursorrules`, `.clinerules`, or
`.windsurfrules`) belong in the selected host adapter. Generic adapter
templates are provided under `adapters/hosts/`.

### 🔌 4. Adapter Layer (`adapters/`)
Host, memory, tool, and provider templates that connect the portable core to a
specific AI environment. Adapters are optional and must not be required by the
core contracts.

### 🛡️ 5. Policy and Verification
- **`policies/permissions.yaml`**: Capability permissions, approval rules, and
  secret-handling constraints.
- **`verification/default.yaml`**: Host-neutral completion and evidence policy.
- **`agents/registry.yaml`**: Portable TARS orchestrator, implementer, researcher,
  reviewer, and archivist role contracts.

---

## 🚀 AI-Harness Mode

The AI-Harness is a meta-framework for observing, scoring, and evolving agent behavior through a data-driven feedback loop.

### Onboarding a New Agent
1. **Setup local environment variables** from `.env.example`; keep secrets
   outside version control.
2. **Create local configuration**: Run `cp .env.example .env`, then edit `.env`
   with the values required by the tools you enable.
3. **Bootstrap**: Run `bash .tools/harness/bin/environment_bootstrap.sh` to
   initialize the harness environment.
4. **Policy**: Configure `.tools/harness/harness_policy.yaml` to define scoring
   criteria and evaluation benchmarks.
5. **Collect**: Begin collecting traces via
   `python .tools/harness/scripts/trace_collector.py`.
6. **Evolve**: Run `ai-harness` (score) and
   `python .tools/harness/scripts/meta_optimizer.py` (evolve) to optimize agent
   performance.

---

## 🧠 The Memory Loop (MemGPT-style)

The ecosystem defines a provider-neutral multi-layer memory architecture.
Markdown, SQL, vector, graph, or hosted stores may implement the memory
adapter; no specific provider is required.

1.  **Working Memory (Contextual)**: The immediate task context and active files.
2.  **Episodic Memory**: A record of events, decisions, and lessons learned
    in the configured durable store.
3.  **Semantic Memory**: A structured library of technical patterns and
    learned expertise in the configured durable store.

**Agents are expected to:**
- **Capture**: Record decisions and learnings after significant tasks.
- **Retrieve**: Proactively search the configured memory adapter before
  starting new tasks.

---

## 🤖 Agent Deployment Protocol

### For an Orchestrator Agent
1. Select TARS as the sole orchestrator.
2. Point the agent's knowledge base/context to `.core/` to grant it access to
   the Skill Catalog, Mindset, and Engineering Principles.
3. Instruct the agent to use the **Memory Loop** to manage task-to-task continuity.

### For a Deep-Engineering Agent
1. Select a deep-engineering persona appropriate to the host environment.
2. Ensure the agent follows a written implementation plan for complex tasks.
3. Require the agent to perform **Decision Logging** through the configured
   memory adapter after structural changes.

## 🔌 Host Integration

The repository does not require a specific AI host. An adapter should map the
portable core to the host's instruction format, skill loader, tool protocol,
memory provider, and verification commands. Keep adapter scripts and provider
configuration outside the portable contracts and document their paths locally.

---

## 🚀 Philosophy: The Caveman Principle

To maximize efficiency and minimize token consumption, all agents operate in a **"Caveman-inspired"** mode:
- **Direct & Technical**: No fluff, no pleasantries.
- **High Density**: Maximum technical substance per token.
- **Precision-First**: Every word must serve a functional purpose.

---

*Developed for the next generation of autonomous engineering partners.*
