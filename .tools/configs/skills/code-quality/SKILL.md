---
name: code-quality
description: Clean code principles, naming conventions, code structure, and comments policy
---

## Clean Code Principles

- **SOLID**: Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **DRY**: Don't Repeat Yourself
- **KISS**: Keep It Simple, Stupid
- **YAGNI**: You Aren't Gonna Need It
- **Boy Scout Rule**: Leave the code cleaner than you found it

## Naming Conventions

- Use descriptive, self-explanatory names
- Prefer clarity over brevity
- Functions should describe what they do (use verbs)
- Variables should describe what they hold (use nouns)
- Booleans should read as questions: `isActive`, `hasPermission`, `canEdit`
- Avoid abbreviations unless universally understood
- Constants in SCREAMING_SNAKE_CASE

## Code Structure

- Keep functions small and focused (single responsibility)
- Limit function parameters (max 3-4, use objects for more)
- Prefer composition over inheritance
- Write code that reads like prose
- Avoid deep nesting (max 2-3 levels, use early returns)
- Group related code together
- Separate pure functions from side effects

## Comments Policy

- Code should be self-documenting
- Avoid obvious comments that describe "what" the code does
- Only comment "why" when the reasoning isn't obvious
- If you need comments to explain code, refactor the code instead
- JSDoc/TSDoc for public APIs only when necessary
- TODO comments must include context and owner

## Complexity Rules

- Functions with cyclomatic complexity > 5 MUST be refactored
- Max function length: ~30 lines (prefer shorter)
- Max file length: ~300 lines (split if larger)
- Max nesting depth: 3 levels
