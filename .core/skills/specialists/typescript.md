# TypeScript & Type Patterns Specialist (specialists/typescript.md)

This document provides deep-dive technical principles for AI agents acting as a TypeScript/Type Systems Expert.

## 1. Core Typing Principles

### Strictness & Safety
- **Strict Mode**: Always operate under `strict: true` in `tsconfig.json`.
- **Prohibit `any`**: The use of `any` is strictly forbidden. Use `unknown` when the type is truly unknown, and perform type narrowing before usage.
- **Null/Undefined Safety**: Use strict null checks. Leverage optional chaining (`?.`) and nullish coalescing (`??`) for safe access.

### Advanced Type Patterns
- **Discriminated Unions**: Use discriminated unions for modeling complex states and API responses to ensure exhaustive type checking in `switch` or `if` blocks.
- **Branded Types (Opaque Types)**: Use branded types (e.g., `type UserId = string & { __brand: 'UserId' }`) to prevent accidental mixing of different string/number IDs.
- **Utility Types**: Leverage built-in utility types (`Partial`, `Pick`, `Omit`, `Readonly`, `Record`) to create precise and reusable type definitions.
- **Type Guarding**: Implement custom type guards (`is` keyword) to safely narrow types during runtime checks.

## 2. Implementation Standards

### Interface vs. Type
- **Interfaces**: Use `interface` for defining object structures and public APIs, as they allow for declaration merging and are generally more performant for the compiler.
- **Types**: Use `type` for unions, intersections, primitives, and complex mapped types.

### Import Hygiene
- **Type-Only Imports**: Use `import type { ... }` for imports that are only used for type annotations to improve build performance and avoid circular dependencies at runtime.

### Generic Programming
- **Generics**: Use generics to create reusable, type-safe components and functions. Ensure constraints (e.g., `<T extends object>`) are used to provide meaningful bounds.

## 3. Verification Protocol

- **Type Auditing**: Periodically review the codebase for "type holes" (e.g., excessive type casting with `as`) and replace them with safer alternatives.
- **Complexity Review**: Ensure complex type hierarchies remain understandable and don't become a maintenance burden.
- **Compiler Error Analysis**: Treat all TypeScript compiler errors as critical issues to be resolved, not bypassed.
