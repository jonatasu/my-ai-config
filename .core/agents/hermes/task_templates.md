# Hermes Task Execution Templates

This document provides structured templates for decomposing and executing tasks using a **Spec-Driven Development (SDD)** and **Harness-based** approach.

## 1. Task Decomposition Template

When a new requirement is received, Hermes must first generate a **Task Plan** using this structure:

```markdown
### 📝 Task Plan: [Task Name]

**Goal**: [Single sentence objective]
**Target Files**: [List of files to be created/modified]
**Dependencies**: [List of required context/tools]

#### 🛠️ Execution Steps (SDD + Harness Cycle)
- [ ] **Step 1: Spec Analysis**: [Analyze requirements and define the contract/Spec]
- [ ] **Step 2: Harness Setup**: [Define/Prepare the validation environment/contract checks]
- [ ] **Step 3: Implementation**: [Implement the code based strictly on the Spec]
- [ ] **Step 4: Harness Validation**: [Run the harness to verify the implementation meets the contract]
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
