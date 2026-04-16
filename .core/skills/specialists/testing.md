# Testing Specialist Guidelines (specialists/testing.md)

This document provides deep-dive technical principles for AI agents acting in a Quality Assurance (QA) & Testing role.

## 1. Core Testing Principles

### Testing Strategy
- **Testing Pyramid**: Maintain a healthy balance of tests, prioritizing a large base of fast, reliable Unit Tests, followed by a medium layer of Integration Tests, and a small, critical layer of End-to-End (E2E) Tests.
- **Behavior over Implementation**: Test *what* the system does (behavior), not *how* it does it (implementation details). This ensures tests remain resilient during refactoring.
- **Deterministic Tests**: Ensure tests are reliable and repeatable. Avoid non-deterministic (flaky) tests by properly mocking external dependencies, controlling time, and managing state.

### Test Quality
- **Code Coverage**: Target meaningful coverage (e.g., 70-90%), but prioritize testing high-risk and complex logic over chasing 100% coverage on trivial code.
- **Boundary & Edge Case Testing**: Proactively test boundary conditions, invalid inputs, error states, and unexpected user behaviors.
- **Regression Testing**: Ensure that every bug fix is accompanied by a new test case to prevent future regressions.

## 2. Implementation Standards

### Tooling & Patterns
- **Unit Testing**: Use lightweight, fast frameworks (e.g., Vitest, Jest) for testing individual functions and components in isolation.
- **Integration Testing**: Test the interaction between multiple modules, services, or components to ensure they work together correctly.
- **E2E Testing**: Use robust tools (e.g., Playwright, Cypress) to test critical user journeys in a real browser environment.
- **Page Object Model (POM)**: In E2E testing, use the Page Object Model to decouple test logic from UI selectors, increasing maintainability.

### Mocking & Isolation
- **Mock External Dependencies**: Use mocks or stubs for third-party APIs, databases, and complex services to ensure tests are fast, isolated, and predictable.
- **Controlled Environment**: Ensure a clean, predictable state before every test execution.

## 3. Verification Protocol

- **Continuous Testing**: Integrate automated tests into the CI/CD pipeline to catch regressions early.
- **Test Reporting**: Provide clear, actionable reports that identify exactly what failed and why (e.g., screenshots/videos for E2E failures).
- **Flakiness Audit**: Regularly identify and fix flaky tests to maintain developer trust in the test suite.
