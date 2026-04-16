---
name: code-review
description: Comprehensive code review checklist covering security, performance, quality, and maintainability
---

## Review Process

1. Understand the context and purpose of the changes
2. Run through each checklist section below
3. For each issue found, provide: file path, line number, issue type, description, and suggested fix
4. Classify issues by severity: Critical, High, Medium, Low
5. After listing all issues, ask which ones to fix

## Security Checklist

- [ ] No hardcoded secrets, keys, or credentials
- [ ] Input validation and sanitization present
- [ ] Protection against SQL injection
- [ ] Protection against XSS (Cross-Site Scripting)
- [ ] Protection against CSRF (Cross-Site Request Forgery)
- [ ] Proper authentication checks
- [ ] Proper authorization checks
- [ ] Secure data handling and encryption
- [ ] Dependencies are up to date
- [ ] No known vulnerabilities in dependencies
- [ ] Sensitive data not logged or exposed

## Performance Checklist

- [ ] Appropriate algorithmic complexity (Big O)
- [ ] No unnecessary loops or redundant operations
- [ ] Efficient database queries (no N+1 problems)
- [ ] Proper caching strategies where applicable
- [ ] No memory leaks
- [ ] Lazy loading implemented where appropriate
- [ ] No blocking operations in async code
- [ ] Proper pagination for large datasets

## Quality Checklist

- [ ] Adequate test coverage for new code
- [ ] Error handling and edge cases covered
- [ ] Consistent with existing codebase patterns
- [ ] No code duplication (DRY principle)
- [ ] Clear separation of concerns
- [ ] Proper typing (for typed languages)
- [ ] No commented-out code
- [ ] No debug statements left behind

## Maintainability Checklist

- [ ] Easy to understand without comments
- [ ] Modular and extensible design
- [ ] Follows project conventions
- [ ] Meaningful variable and function names
- [ ] Small, focused functions (single responsibility)
- [ ] Cyclomatic complexity <= 5 per function
- [ ] No deep nesting (max 3 levels)

## Accessibility Checklist (UI Components)

- [ ] Semantic HTML elements used
- [ ] ARIA labels where needed
- [ ] Keyboard navigation works
- [ ] Color contrast is sufficient
- [ ] Focus states are visible
- [ ] Screen reader compatible

## Output Format

For each issue found:

```
### [SEVERITY] Issue Title
- **File**: path/to/file.ts
- **Line**: 42
- **Type**: Security | Performance | Quality | Maintainability | Accessibility
- **Description**: Clear explanation of the issue
- **Suggestion**: How to fix it
```
