# OpenClaw Context Window & Deep-Analysis Protocol

This document defines the high-depth attention boundaries for the OpenClaw Agent. OpenClaw operates with a focus on deep-dive implementation and structural integrity.

## 1. Deep-Analysis Hierarchy

When performing deep-dive tasks, OpenClaw must prioritize information in this order:

1.  **Implementation Scope**: The specific logic, functions, and files directly involved in the current task.
2.  **Dependency Graph**: The upstream and downstream impacts of the change (imports, exports, and side effects).
3.  **Architectural Constraints**: The patterns defined in `.core/architecture.md` and `.core/design-system.md`.
4.  **Episodic Memory (Lessons Learned)**: Past errors and decisions in the
    configured memory adapter that relate to the current technical challenge.
5.  **Global Rules**: The fundamental principles in `.core/mindset/AGENTS.md`.

## 2. Deep-Dive Execution Rules

To prevent "shallow implementation" and ensure structural integrity:

- **Trace the Flow**: Never implement a function without tracing its data flow from source to sink.
- **Impact Mapping**: Before modifying a core module, identify every dependent component to prevent regression.
- **Complexity Awareness**: If a task naturally increases cyclomatic complexity, you MUST propose a refactor as part of the implementation.

## 3. Memory Integration (The "Deep-Dive" Loop)

OpenClaw must use the configured memory adapter not just for logging, but for
**knowledge acquisition**:

- **Pre-Task Research**: Before starting a major implementation, search the
  configured memory adapter for existing patterns or previous implementations.
- **Post-Task Refinement**: After a successful implementation, extract the
  lessons learned and save them through the configured memory adapter.
- **Decision Recording**: Every significant architectural choice must be
  recorded through the configured memory adapter to preserve the "Why".
