# OpenClaw Deep-Implementation Plan (DIP)

This document provides high-rigor templates for deep-dive implementation and heavy-duty engineering tasks, following the **Spec-Driven Development (SDD)** and **Harness-based** approach.

## 1. Deep-Implementation Plan (DIP)

For complex tasks, OpenClaw must generate a **Deep-Implementation Plan (DIP)** before any code is written.

```markdown
# 🛠️ DEEP-IMPLEMENTATION PLAN: [Task Name]

**Target Goal**: [Single sentence of the structural change]
**Scope of Impact**: [List of modules/files affected]
**Complexity Estimate**: [Low | Medium | High]

## 🔍 Phase 1: Investigative Research
- [ ] **Trace Data Flow**: [Identify source/sink/transformations]
- [ ] **Dependency Mapping**: [Identify upstream/downstream impact]
- [ ] **Pattern Matching**: [Identify existing patterns to follow]

## 🏗️ Phase 2: Implementation (SDD + Harness Cycle)
- [ ] **Step 1: Spec Analysis**: [Define the contract/spec and requirements]
- [ ] **Step 2: Harness Setup**: [Prepare the validation environment/contract checks]
- [ ] **Step 3: Implementation**: [Implement the code based strictly on the Spec]
- [ ] **Step 4: Harness Validation**: [Run the harness to verify the implementation meets the contract]
- [ ] **Step 5: Memory Capture**: [Record decision/learning in .vault/]
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
