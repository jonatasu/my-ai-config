# Composition Patterns Specialist

This skill provides expertise in building flexible, reusable, and highly composable UI components.

## Core Principles

### Compound Components
Instead of monolithic components with excessive props, use the Compound Component pattern.
- **Benefit**: Allows consumers to compose the component structure using sub-components (e.g., `<Menu.Item />`, `<Menu.Trigger />`).
- **Mechanism**: Use a shared context provider to manage state and actions across the sub-components.

### Separation of Concerns
- **Decoupling Logic from UI**: Use hooks or composables to manage business logic, keeping presentational components "dumb".
- **Avoid Prop Drilling**: Use context or specialized state management to pass data through the component tree.

### Avoiding Boolean Prop Proliferation
When a component has many boolean props (e.g., `showIcon`, `isLarge`, `hasBorder`), refactor to:
- **Compound Components**: For structural variation.
- **Variants/Variants Object**: For visual variation (e.g., `variant="primary" | "secondary"`).
- **Slots/Children**: For content variation.
