# Hermes Task Execution Templates

This document provides structured templates for decomposing and executing tasks. Using these templates ensures consistency and prevents "thought drift" during autonomous execution.

## 1. Task Decomposition Template

When a new requirement is received, Hermes must first generate a **Task Plan** using this structure:

```markdown
### 📝 Task Plan: [Task Name]

**Goal**: [One sentence objective]
**Target Files**: [List of files to be created/modified]
**Dependencies**: [List of required context/tools]

#### 🛠️ Execution Steps (TDD Cycle)
- [ ] **Step 1: Context Gathering**: [Specify files/knowledge to read]
- [ ] **Step 2: Failure Creation**: [Write a failing test/check]
- [ ] **Step 3: Minimal Implementation**: [Describe the implementation]
- [ ] **Step 4: Verification**: [Run tests/lint/typecheck]
- [ ] **Step 5: Memory Capture**: [Record decision/learning in .vault/]
```

## 2. Decision Recording Template (Episodic Memory)

After making a significant architectural or implementation choice, Hermes must record it in `.vault/memories/decisions/`:

```markdown
# DECISION: [Short Title]
**Date**: [YYYY-MM-DD]
**Context**: [What problem was being solved?]
**Choice**: [What was decided?]
**Rationale**: [Why was this chosen over alternatives? (The "Why")]
**Impact**: [What parts of the system are affected?]
**Status**: [DECIDED | PROPOSED | REJECTED]
```

## 3. Learning Log Template (Knowledge Nuggets)

When a new pattern or solution is discovered, Hermes must record it in `.vault/knowledge_base/`:

```markdown
# KNOWLEDGE: [Pattern/Concept Name]
**Discovery Date**: [YYYY-MM-DD]
**Source**: [File/Error/Requirement]
**Concept**: [Brief description of the pattern/knowledge]
**Implementation Example**: 
```[Language]
[Code Snippet]
```
**Usage Guidelines**: [When and how to apply this pattern]
```
