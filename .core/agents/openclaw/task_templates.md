# OpenClaw Task Execution & Implementation Templates

This document provides high-rigor templates for deep-dive implementation and heavy-duty engineering tasks.

## 1. Deep-Implementation Plan (DIP)

For complex tasks, OpenClaw must generate a **Deep-Implementation Plan** before any code is written.

```markdown
# 🛠️ DEEP-IMPLEMENTATION PLAN: [Task Name]

**Target Goal**: [Single sentence of the structural change]
**Scope of Impact**: [List of modules/files affected]
**Complexity Estimate**: [Low | Medium | High]

## 🔍 Phase 1: Investigative Research
- [ ] **Trace Data Flow**: [Identify source/sink/transformations]
- [ ] **Dependency Mapping**: [Identify upstream/downstream impact]
- [ ] **Pattern Matching**: [Identify existing patterns to follow]

## 🏗️ Phase 2: Implementation (TDD Driven)
- [ ] **Step 1: Red Phase**: Write the failing test(s) covering edge cases.
- [ ] **Step 2: Green Phase**: Implement the minimal code to pass.
- [ ] **Step 3: Refactor Phase**: Optimize for complexity, typing, and performance.
- [ ] **Step 4: Verification**: Run full suite + lint + typecheck.

## 🧠 Phase 3: Memory Capture
- [ ] **Decision Log**: Record architectural choices in `.vault/memories/decisions/`.
- [ ] **Learning Log**: Record technical hurdles and resolutions in `.vault/memories/learnings/`.
```

## 2. Error Analysis Template

When a bug is encountered or a test fails, OpenClaw must use this template for its internal reasoning and eventual report:

```markdown
### 🚨 Error Analysis: [Error Message/Issue]

**Symptom**: [What is visibly happening?]
**Observed Behavior**: [Actual vs Expected]
**Root Cause Hypothesis**: [What is the likely culprit?]
**Investigation Path**: [How did I trace it? (Files, Stack Trace, Debugging steps)]
**Resolution**: [How was it fixed?]
**Preventative Measure**: [What can be changed in code/tests to prevent this?]
```

## 3. Refactor Proposal Template

When complexity limits are breached, OpenClaw must propose a refactor using this format:

```markdown
### 🔨 Refactor Proposal: [Component/Function Name]

**Current Problem**: [High complexity, prop drilling, etc.]
**Proposed Solution**: [Describe the new pattern/structure]
**Expected Benefits**: [Maintainability, Performance, Testability]
**Implementation Plan**: [Brief steps for the refactor]
```
