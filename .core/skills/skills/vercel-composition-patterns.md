# Advanced Component Architecture Specialist

## Purpose & Domain
Expertise in designing scalable, flexible, and maintainable component architectures, specifically for modern declarative UI frameworks (e.g., React). Focuses on preventing component complexity explosion by utilizing advanced composition patterns, efficient state management, and modern framework APIs.

## Professional Workflow

1.  **Complexity Audit**: Analyze existing components for "prop drilling," "boolean prop proliferation" (too many conditional props), and monolithic structures that are difficult to test or extend.
2.  **Architecture Selection**: Determine the optimal pattern for the component's purpose:
    - **Compound Components**: For complex, multi-part UI elements that require shared state and flexible sub-component arrangement.
    - **Explicit Variants**: For components that have distinct, well-defined modes (e.g., a "Primary Button" vs. a "Ghost Button") that are better handled as separate entities than as a single component with many toggles.
3.  **State Design**: Define how state will be managed and shared. Decide whether to lift state into a provider, use local state, or rely on external state management, ensuring a clear boundary between state implementation and UI representation.
4.  **Interface Definition**: Design clean, predictable, and type-safe APIs for components. Prioritize composition over configuration.
5.  **Implementation**: Develop the component(s) using the chosen pattern, ensuring that internals are properly encapsulated and the public API is minimal and powerful.
6.  **Refactoring**: Systematically transition monolithic or "prop-heavy" components into composed, modular structures.

## Core Principles & Standards

### 1. Component Architecture (High Impact)
- **Avoid Boolean Prop Proliferation**: Do not use numerous boolean props (e.g., `isEditing`, `isModal`, `hasHeader`) to control component internals. This leads to exponential state combinations and unmaintainable logic.
- **Prefer Composition**: Instead of configuring a single component with dozens of props, allow users to compose the component by nesting sub-components.
- **Use Compound Components**: Structure complex UI elements (like Tabs, Selects, or Modals) as a set of related components that communicate via a shared context. This allows the consumer to decide the exact layout and order of the pieces.

### 2. State Management (Medium Impact)
- **Decouple State from UI**: The UI components should only know *how to display* data and *how to trigger* actions. They should not know *where* the data comes from (e.g., whether it's from a local hook, a global store, or a server).
- **Lifting State**: Move shared state into dedicated Provider components. This enables sibling components—even those outside the main visual container—to access and modify the state without complex prop drilling.
- **Generic Context Interfaces**: Define clear, type-safe interfaces for context (e.g., `state`, `actions`, `meta`) to enable dependency injection and testing.

### 3. Implementation Patterns (Medium Impact)
- **Explicit Variants**: When a component has distinct modes, create dedicated, named variant components (e.g., `PrimaryButton`, `SecondaryButton`) rather than one monolithic component with a `variant="primary|secondary"` prop if the logic diverges significantly.
- **Prefer Children Over Render Props**: Use the `children` prop for structural composition. Only use render props when the parent component *must* provide dynamic data back to the child during the rendering process.

### 4. Modern Framework Optimization (Medium Impact)
- **Leverage Latest APIs**: Utilize modern framework features (e.g., `ref` as a regular prop or the `use()` hook in React 19) to simplify component definitions and reduce boilerplate.
- **Stay Current**: Periodically review framework updates to identify deprecated patterns (like `forwardRef` or `useContext`) that can be replaced by more streamlined alternatives.

## Decision Logic

- **If a component has >3 boolean props used for structural customization** $\rightarrow$ Refactor using **Compound Components**.
- **If a component's logic is becoming a "giant switch statement" of props** $\rightarrow$ Refactor into **Explicit Variants**.
- **If you need to pass state deeply through many layers of UI** $\rightarrow$ Use **Lifting State into Providers**.
- **If the UI needs to be highly flexible/customizable by the user** $\rightarrow$ Use **Composition via Children**.
- **If the component logic is tightly coupled to a specific state library** $\rightarrow$ Apply **Decoupling State Management from UI**.
