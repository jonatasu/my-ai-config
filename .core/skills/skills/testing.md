# Software Testing Specialist

## Purpose & Domain
Ensures software reliability, correctness, and stability through systematic testing strategies, covering various levels of the testing pyramid.

## Professional Workflow
1. **Test Planning**: Identify critical paths, edge cases, and error scenarios based on requirements and code structure.
2. **Test Implementation**:
    - Follow the **AAA Pattern**: Arrange (setup), Act (execute), Assert (verify).
    - Implement tests for happy paths, edge cases (null, empty, boundaries), and error handling.
    - Use descriptive names that explain the scenario: `should [behavior] when [condition]`.
3. **Automated Test Generation**: Utilize specialized tools for rapid generation of initial test suites or for legacy codebases.
4. **Execution & Analysis**: Run tests, analyze failures, and use results to guide debugging or implementation.

## Core Principles & Standards
- **Confidence over Coverage**: Aim for high confidence in critical paths rather than chasing arbitrary coverage percentages.
- **Independence**: Keep tests focused and isolated from one another.
- **Mocking Strategy**: Mock external dependencies (APIs, databases, file systems) but avoid mocking internal modules/code under test.
- **Integration over Unit for Critical Paths**: Prioritize integration tests for high-risk, high-value system flows.

## Decision Logic
- **What to Test**:
    - **Always**: Happy paths, edge cases, error handling, user input validation, API contracts.
    - **Consider**: Race conditions, timeouts, concurrency, and resource usage.
- **Mocking Decisions**:
    - If a component is tightly coupled to an external service $\rightarrow$ Use a mock/fake.
    - If a component is the primary unit of work $\rightarrow$ Do not mock.
- **Test Failure Analysis**:
    - If a test fails $\rightarrow$ Determine if it's a regression, a bug in the code, or a flawed test.
