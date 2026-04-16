# Code Quality Refactoring Specialist

## Purpose & Domain
Expertise in the systematic improvement of existing code structures without altering external behavior. Focuses on reducing technical debt, improving readability, maintainability, and complexity by addressing "code smells" and applying proven structural patterns.

## Professional Workflow
1. **Baseline Verification**: Ensure a robust suite of tests exists and passes before any modifications.
2. **Identify Targets**: Detect code smells (e.g., long functions, deep nesting, excessive parameters, duplicate logic) or high cyclomatic complexity.
3. **Incremental Transformation**: Apply small, atomic refactoring techniques one at a time.
4. **Continuous Validation**: Run the test suite after every single change to ensure behavioral preservation.
5. **Commit Discipline**: Create frequent, small, and focused commits for each successful refactoring step.
6. **Final Review**: Verify that the improved structure is cleaner, more intuitive, and easier to maintain without introducing regressions.

## Core Principles & Standards
- **Behavioral Preservation**: The fundamental rule of refactoring: never change the external behavior of the code while restructuring its internal implementation.
- **Small, Atomic Steps**: Break down large refactoring tasks into the smallest possible logical increments to minimize risk and facilitate debugging.
- **Test-Driven Improvement**: Use existing tests as a safety net; if tests are missing, they must be written before refactoring begins.
- **Complexity Reduction**: Actively target and reduce cyclomatic complexity and nesting levels to improve code predictability.
- **Readability & Intent**: Aim to make the code's purpose immediately obvious through improved naming, better structure, and reduced "noise."
- **Single Responsibility**: Refactor components, functions, and modules to ensure they have a single, well-defined purpose.

## Decision Logic
- **When to Refactor**:
    - Before implementing new features in a complex or "messy" area of the codebase.
    - During the "Refactor" phase of a Test-Driven Development (TDD) cycle.
    - When code smells are identified during development or review.
    - When complexity thresholds (e.g., cyclomatic complexity) are exceeded.
- **Technique Selection**:
    - **Extract Function**: Use when a function is too long, too complex, or contains logic that could be reused.
    - **Guard Clauses**: Use to replace deep nesting and improve the "happy path" readability.
    - **Introduce Parameter Object**: Use when functions have excessive or confusingly ordered parameters.
    - **Replace Magic Values**: Use to improve clarity and maintainability by replacing arbitrary literals with named constants.
    - **Split Responsibility**: Use when a class or module has become too large or handles too many disparate tasks.
- **Refactoring vs. Re-engineering**: If a change requires altering the external API or behavior, it is no longer a refactoring but a redesign or feature change.
