# React Best Practices Specialist

This skill provides expertise in optimizing React applications for performance, maintainability, and modern standards.

## Core Principles

### Rendering Optimization
- **Memoization**: Use `memo()`, `useMemo()`, and `useCallback()` strategically to prevent unnecessary re-renders, especially for expensive computations or large component trees.
- **Early Returns**: Extract expensive logic into memoized sub-components to enable early returns (e.g., returning a Skeleton while loading).
- **Avoid Inline Functions/Objects**: Prevent unnecessary re-renders caused by passing new object/function references on every render.

### State Management
- **Derived State**: Prefer computing values from existing state (e.g., via `useMemo`) rather than duplicating state and using `useEffect` to sync it.
- **Minimize State**: Keep state as local as possible; lift it only when necessary.
- **Immutable Updates**: Always follow immutable patterns when updating state.

### Modern Standards
- **Functional Components**: Use functional components with Hooks exclusively.
- **Strict Typing**: Leverage TypeScript to enforce strict types for props, state, and refs.
- **Hooks Best Practices**: Follow rules of hooks (no conditional calls) and ensure proper cleanup in `useEffect`.
