# 🧠 JOW-AI Omni-Agent Ecosystem

This repository is the unified intelligence and tooling framework for the JOW-AI ecosystem. It is designed to provide AI agents with both a **Cognitive Core** (how to think and what to know) and an **Operational Toolkit** (how to act and execute).

---

## 🏗️ Architecture Overview

The repository is organized into three primary functional layers to ensure a clear separation of concerns between identity, expertise, and execution.

### 🧠 1. The Cognitive Core (`.core/`)
This is the "Brain" of the agent. It defines the fundamental identity, mindset, and specialized knowledge.
- **`.core/agents/`**: Defines the core identities and specialized personas (e.g., `hermes`, `openclaw`). Each agent has its own `SOUL.md` and `GUIDELINES.md`.
- **`.core/mindset/`**: Contains the fundamental behavioral guidelines and decision-making protocols (e.g., `AGENTS.md` with the "Caveman Mode").
- **`.core/skills/`**: A library of professional expertise modules. These are "Specialist" personas (e.g., `security`, `ux`, `performance`) that agents can invoke to perform deep-dive reviews.

### 🛠️ 2. The Operational Toolkit (`.tools/`)
This represents the "Hands" of the agent. It contains the tools and configurations needed to interact with the external world.
- **`.tools/tool-configs/`**: Configuration files for external tools and services (e.g., `claude-api`, `copilot`, `vercel`).
- **`.tools/tool-implementations/`**: Scripts, templates, and code for task execution (e.g., automation scripts, file manipulation tools).

### 📏 3. The Rulebook (`.rules/`)
Standardized instruction files for IDEs and CLI tools to ensure local development compliance.
- Includes `.cursorrules`, `.clinerules`, `.windsurfrules`, and `.aider.conf.yml`.

---

## 🤖 Agent Decision Protocol

Agents operating within this ecosystem follow a specific cognitive workflow:

1.  **Identify Capability**: When a request is received, the agent checks its `.core/skills/` to see if a specialist is required.
2.  **Decompose Task**: The agent uses the `writing-plans` principles to break complex tasks into atomic, bite-sized steps.
3.  **Execute with Precision**: Tasks are executed following the TDD (Test-Driven Development) cycle: *Write failing test $\rightarrow$ Implement minimal code $\rightarrow$ Verify success*.
4.  **Self-Review**: Before reporting completion, the agent must perform an autonomous review based on its assigned persona's expertise.

## 🚀 Configuration Guide for Orchestrators

This repository is optimized for integration with orchestrators like **OpenCode**, **Cline**, **Cursor**, and **Windsurf**.

### Configuring the Hermes Agent
To configure the **Hermes Agent** using this framework, point its context-awareness to this repository and instruct it to:
1.  **Load Identity**: Read `.core/agents/hermes/GUIDELINES.md`.
2.  **Adopt Mindset**: Adhere to the principles in `.core/mindset/AGENTS.md`.
3.  **Use Capabilities**: Invoke specialists via slash commands (e.g., `/as-security-helper`) defined in the `.core/skills/` library.
4.  **Follow Workflow**: Use the implementation protocols defined in `.core/workflow.md`.

---

## 📜 Philosophy: The Caveman Principle

To maximize efficiency and minimize token consumption, this ecosystem operates under the **Caveman Principle**:
- **Extreme Brevity**: Prioritize high information density. Minimize linguistic fluff.
- **Technical Precision**: Use direct, technical statements.
- **On-Demand Verbosity**: Only provide detailed, conversational, or pedagogical explanations when explicitly requested.

---
*Built for the future of autonomous engineering.*
