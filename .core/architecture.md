# Architecture & Component Composition

This document defines the principles for building modular, scalable, and performant software interfaces.

## 1. Composition Patterns

### Compound Components
For complex UI elements, use the Compound Component pattern to allow flexible orchestration by the consumer.
- **Structure**: A parent `Provider` manages shared state/context, and multiple child components provide the UI parts.
- **Benefit**: Avoids "Prop Drilling" and removes the need for complex, monolithic components filled with conditional rendering.
- **Example**: `Menu.Trigger`, `Menu.List`, `Menu.Item`.

### Smart vs. Dumb Components
Maintain a clear separation between logic and presentation:
- **Presentational (Dumb) Components**: Pure UI components. They receive data via props and emit events. They have no business logic and are highly reusable.
- **Container (Smart) Components**: Orchestration layers. They connect to stores, fetch data, handle business logic, and coordinate child components.

## 2. Performance & Rendering

### Memoization Strategy
- **Extracting for Early Returns**: Extract expensive computations or heavy UI parts into memoized sub-components. This allows parent components to perform "early returns" (e.g., showing a Loading Skeleton) without triggering the heavy computation.
- **Avoid Over-Memoization**: Do not memoize simple components. Rely on the framework's compiler (e.g., React Compiler) or use memoization only where measurable performance gains are needed.

### State Management
- **Derive, Don't Duplicate**: Use computed properties or derived state instead of creating new state variables that mirror existing ones.
- **Side Effect Isolation**: Keep side effects (API calls, DOM manipulation) strictly within lifecycle hooks, event handlers, or dedicated composables/hooks.

## 3. Complexity Limits

To maintain maintainability, adhere to these quantitative constraints:
- **Cyclomatic Complexity**: $\le 5$ per function.
- **Component Size**: $< 200$ lines of code.
- **Prop Count**: $< 7$ per component.
- **Nesting Depth**: Max 3 levels of component nesting.
- **Function Parameters**: Max 4. Use an options object for more.
