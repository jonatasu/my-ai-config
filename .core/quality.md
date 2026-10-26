# Quality, Security & Compliance

This document defines the "Red Lines" and quality standards for all AI-generated code and operations.

## 1. Security & Data Integrity

### Zero-Trust Secret Policy
- **Never** commit API keys, tokens, passwords, or any sensitive credentials.
- **Always** use environment variables for configuration.
- **Validate** all external inputs (URLs, file paths, user IDs) to prevent injection attacks.

### Data Handling
- **PII Protection**: Never log Personally Identifiable Information (PII), passwords, or session tokens.
- **Error Masking**: Ensure error messages returned to clients are helpful but do not leak internal implementation details or stack traces.

## 2. Code Quality Standards

### Typing & Strictness
- **Strict Typing**: Use strict type modes. Avoid `any` at all costs; use `unknown` if the type is uncertain.
- **Interface over Type**: Use `interface` for defining object shapes and `type` for unions/intersections.
- **Type-Only Imports**: Use `import type` for type-only imports.

### Complexity Management
- **Refactor Early**: If a function or component exceeds complexity limits (Complexity $> 5$ or Lines $> 200$), propose a refactor immediately.
- **Atomic Changes**: Ensure every code change is focused on a single responsibility.

## 3. Automated Verification

### Mandatory Pre-Commit/Pre-Merge Checks
Before claiming a task as `DONE`, the agent must ensure:
1. **Linting**: Code passes all style and syntax checks.
2. **Type Checking**: No type errors exist in the codebase.
3. **Testing**: All relevant unit and integration tests pass.
4. **Security Audit**: No secrets are present in the diff.

### Reviewer Personas
When performing a code review, the agent should adopt specific "Helper" perspectives:
- **UX Helper**: Focus on usability and user flows.
- **A11y Helper**: Focus on WCAG compliance and accessibility.
- **Performance Helper**: Focus on bundle size and runtime efficiency.
- **Security Helper**: Focus on auth, XSS, and data handling.

### Cross-Repository Feature Review
For features that cross renderer, design-system, and engine boundaries, review the complete contract path before declaring completion:

1. **Authoritative contract**: verify the source model, published OpenAPI schema, generated client model, and renderer adapter use the same discriminator, fields, enums, defaults, and optional values.
2. **Shared repository contracts**: inspect and exercise project-enforced helpers such as root-prop, registry, accessibility, and event contracts instead of duplicating their behavior locally.
3. **Boundary and fallback cases**: test invalid, missing, changed, and failed values, including rerenders that remove previously supplied attributes or state.
4. **External resources**: keep real integration URLs in documentation when useful, but intercept them in automated stories/tests so validation is deterministic and offline-capable.
5. **Independent review**: request a fresh review after the final edit and resolve findings before committing.
6. **Story actions**: use isolated/example origins for clickable Storybook actions; never navigate reviewers or CI to real external services.
7. **Normative documentation**: when implementation changes a repository convention or public behavior, update the authoritative migration/documentation rule and test the documented path.
