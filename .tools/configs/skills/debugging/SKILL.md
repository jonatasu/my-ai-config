---
name: debugging
description: Systematic debugging strategies, common patterns, and troubleshooting techniques
---

## Debugging Process

1. **Reproduce** - Confirm you can reproduce the issue consistently
2. **Isolate** - Narrow down where the problem occurs
3. **Identify** - Find the root cause, not just symptoms
4. **Fix** - Implement the minimal fix
5. **Verify** - Confirm the fix works and doesn't break other things
6. **Prevent** - Add tests to prevent regression

## Common Debugging Strategies

### Binary Search
- Comment out half the code
- If bug persists, it's in the remaining half
- Repeat until you find the culprit

### Rubber Duck Debugging
- Explain the code line by line
- Often reveals assumptions that are wrong

### Print/Log Debugging
- Add strategic console.log/print statements
- Log inputs, outputs, and intermediate states
- Remove or convert to proper logging after

### Git Bisect
- Find the commit that introduced the bug
- `git bisect start`, `git bisect bad`, `git bisect good <commit>`

## Common Bug Patterns

### Off-by-One Errors
- Check loop boundaries: `<` vs `<=`
- Check array indices: 0-based vs 1-based
- Check string slicing boundaries

### Null/Undefined References
- Check if variable is initialized
- Check if API returned expected data
- Add null checks or use optional chaining

### Async/Timing Issues
- Race conditions between operations
- Missing `await` on async functions
- Stale closures in callbacks

### State Management
- State mutated unexpectedly
- State not updated when expected
- Stale state from closures

### Type Coercion (JavaScript)
- `==` vs `===` comparison
- Falsy values: `0`, `""`, `null`, `undefined`, `NaN`
- Array/object comparison by reference

## Questions to Ask

1. What changed recently? (code, dependencies, config)
2. Does it happen consistently or intermittently?
3. Does it happen in all environments?
4. What are the exact steps to reproduce?
5. What did you expect vs what happened?
6. Are there any error messages or logs?

## Tools to Use

| Tool | Purpose |
|------|---------|
| Browser DevTools | Frontend debugging, network, console |
| `console.log` | Quick value inspection |
| Debugger breakpoints | Step through code execution |
| Network tab | API request/response inspection |
| `git diff` | See what changed |
| `git bisect` | Find breaking commit |

## Output Format

When reporting a bug fix:

```
### Root Cause
[Explain why the bug happened]

### Fix
[Explain the fix and why it works]

### Files Changed
- path/to/file.ts:42 - [what changed]

### How to Verify
[Steps to confirm the fix works]

### Prevention
[Test added or other measures to prevent regression]
```
