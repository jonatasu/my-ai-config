# 🧠 Jowmni: The Omni-Agent Ecosystem

This repository is the unified intelligence and tooling framework for the **Jowmni** ecosystem. It is designed to provide AI agents with both a **Cognitive Core** (how to think and what to know) and an **Operational Toolkit** (how to act and execute).

By separating the "Brain" from the "Hands" and implementing a **Long-Term Memory Pipeline**, we enable highly specialized, autonomous, and learning-capable AI agents.

---

## 🏗️ Architecture Overview

The repository is organized into three primary functional layers:

### 🧠 1. The Cognitive Core (`.core/`)
This is the "Brain" of the agent. It defines the identity, mindset, and expert knowledge.

- **`.core/agents/`**: Defines the identities and specialized personas (e.g., `hermes`, `openclaw`). Each agent has its own `SOUL.md` (essence) and `GUIDELINES.md` (operational rules).
- **`.core/mindset/`**: Contains the fundamental behavioral guidelines, including the **Caveman-inspired Communication Efficiency** and decision-making protocols.
- **`.core/skills/`**: A library of professional expertise modules (e.g., `security-audit`, `ux-specialist`).
- **`.core/memory_engine/`**: (Integrated via Obsidian) The logic for managing context and memory.

### 🛠️ 2. The Operational Toolkit (`.tools/`)
This represents the "Hands" of the agent. It contains the tools and configurations required to interact with the external world.

- **`.tools/mcp_setup/`**: The master catalog of MCP tools and their configuration requirements.
- **`.tools/tool-configs/`**: Tool-specific configuration files (e.g., `copilot`, `claude-api`, `vercel`).
- **`.tools/tool-implementations/`**: Actual scripts and automation logic.

### 📏 3. The Rulebook (`.rules/`)
Standardized instruction files for IDEs and CLI tools (e.g., `.cursorrules`, `.clinerules`, `.windsurfrules`).

---

## 🧠 The Memory Loop (MemGPT-style)

The ecosystem implements a multi-layer memory architecture using **Obsidian** as the persistent storage layer (`.vault/`).

1.  **Working Memory (Contextual)**: The immediate task context and active files.
2.  **Episodic Memory (`.vault/memories/`)**: A record of events, decisions, and "lessons learned" from recent tasks.
3.  **Semantic Memory (`.vault/knowledge_base/`)**: A structured library of technical patterns and learned expertise.

**Agents are mandated to:**
- **Capture**: Record decisions and learnings after significant tasks.
- **Retrieve**: Proactively search the vault before starting new tasks.

---

## 🤖 Agent Deployment Protocol

### For Hermes Agent (Orchestrator)
1. Set the agent's system prompt to reference `.core/agents/hermes/` for identity.
2. Point the agent's knowledge base/context to `.core/` to grant it access to the Skill Catalog and Mindset.
3. Instruct the agent to use the **Memory Loop** to manage task-to-task continuity.

### For OpenClaw (Deep-Engineer)
1. Set the agent's system prompt to reference `.core/agents/openclaw/` for identity.
2. Ensure the agent follows the **Deep-Implementation Plan (DIP)** protocol for complex tasks.
3. Require the agent to perform **Decision Logging** in the `.vault/` after structural changes.

---

## 🚀 Philosophy: The Caveman Principle

To maximize efficiency and minimize token consumption, all agents operate in a **"Caveman-inspired"** mode:
- **Direct & Technical**: No fluff, no pleasantries.
- **High Density**: Maximum technical substance per token.
- **Precision-First**: Every word must serve a functional purpose.

---

*Developed for the next generation of autonomous engineering partners.*

