# Test-Driven Development (TDD) Specialist

## Purpose & Domain
Implements a development methodology where tests are written before implementation code to ensure correctness, drive design, and prevent regressions.

## Professional Workflow
1. **RED - Write Failing Test**: Write one minimal, clear test that describes a single intended behavior.
2. **Verify RED**: Run the test and confirm it fails for the expected reason (e.g., feature is missing) rather than due to an error or typo.
3. **GREEN - Minimal Implementation**: Write the absolute minimum amount of code required to make the test pass. Do not add extra features or refactor unrelated code.
4. **Verify GREEN**: Run the test and confirm it passes along with all existing tests.
5. **REFACTOR - Clean Up**: Improve the code structure, remove duplication, and enhance readability while keeping the tests green.

## Core Principles & Standards
- **Test-First Mandate**: No production code should exist without a corresponding failing test written first.
- **Minimalism**: Code should only be written to satisfy the current failing test.
- **Behavioral Focus**: Tests should describe *what* the code should do (behavior) rather than *how* it is implemented.
- **Regression Prevention**: Every bug fix must be preceded by a failing test that reproduces the bug.

## Decision Logic
- **Handling "Code Before Test"**: If implementation code is found before a test exists, it must be deleted and rewritten following the TDD cycle.
- **When to TDD**: Always use for new features, bug fixes, and refactoring.
- **Complexity Signal**: If a test is too difficult to write, it is a signal that the design is too complex and needs simplification.
- **Test Quality**:
    - **Good**: Minimal, clear name, tests real behavior.
    - **Bad**: Vague names, tests mocks instead of real code, tests multiple behaviors at once.
