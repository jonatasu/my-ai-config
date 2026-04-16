---
name: git-workflow
description: Conventional commits, branch naming, PR guidelines, and git best practices
---

## Conventional Commits

All commits MUST follow the Conventional Commits specification in English.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Code style (formatting, semicolons, etc.) |
| `refactor` | Code refactoring (no feature/fix) |
| `perf` | Performance improvements |
| `test` | Adding or updating tests |
| `build` | Build system or dependencies |
| `ci` | CI/CD configuration |
| `chore` | Maintenance tasks |
| `revert` | Reverting changes |

### Rules

- Use imperative mood: "add feature" not "added feature"
- Keep subject line under 72 characters
- No period at the end of subject line
- Separate subject from body with blank line
- Use body to explain "what" and "why", not "how"
- Reference issues when applicable: `Closes #123`

### Examples

```
feat(auth): add OAuth2 login support

Implement OAuth2 authentication flow with Google and GitHub providers.
This replaces the legacy session-based auth system.

Closes #456
```

```
fix(api): handle null response from payment gateway

The payment gateway occasionally returns null instead of an error object.
Added defensive check to prevent runtime exception.
```

## Branch Naming Convention

```
<type>/<ticket-id>-<short-description>
```

### Types

- `feature/` - New features
- `fix/` - Bug fixes
- `hotfix/` - Urgent production fixes
- `refactor/` - Code refactoring
- `docs/` - Documentation
- `test/` - Test additions/modifications
- `chore/` - Maintenance tasks

### Examples

```
feature/AUTH-123-oauth-login
fix/API-456-null-response-handling
hotfix/PROD-789-payment-timeout
refactor/CORE-321-extract-utils
```

## Pull Request Guidelines

- Keep PRs small and focused (< 400 lines when possible)
- Write clear PR descriptions explaining the "why"
- Link related issues
- Add screenshots for UI changes
- Request reviews from appropriate team members
- Address all review comments before merging
- Ensure CI passes before requesting review

## Git Best Practices

- Keep commits atomic and focused
- Write meaningful commit messages
- Rebase to keep history clean (when appropriate)
- Never commit sensitive data
- Review changes before committing (`git diff --staged`)
- Use `.gitignore` properly
- Squash WIP commits before merging
