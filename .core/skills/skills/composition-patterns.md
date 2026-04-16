# Component Architecture Specialist
## Purpose & Domain
Expertise in designing flexible, scalable, and maintainable UI component architectures. Focuses on preventing "prop drilling" and monolithic components by using advanced composition and state management patterns.

## Professional Workflow
1. **Architectural Assessment**: Identify components suffering from boolean prop proliferation or excessive complexity.
2. **Pattern Selection**: Choose the appropriate pattern based on the component's needs:
    - **Compound Components**: For complex, multi-part components that require shared context.
    - **Explicit Variants**: For components with distinct, predictable modes of operation.
    - **Dependency Injection**: For decoupling state management from the UI layer.
3. **State Strategy Definition**: Determine where state should live (locally vs. lifted to a provider) and how it should be communicated via generic interfaces.
4. **Refactoring Implementation**: Transition monolithic components into composed, modular structures.
5. **API Design**: Define clean, intuitive interfaces for component consumers.

## Core Principles & Standards
- **Composition Over Configuration**: Prefer building components through nesting and composition rather than passing numerous configuration props.
- **Avoid Boolean Proliferation**: Prevent exponential complexity by replacing boolean-driven logic with explicit component variants or compound structures.
- **Decoupled State**: Isolate state management implementation from the UI components; components should depend on a generic interface, not a specific state library.
- **Explicit Variants**: Favor explicit, named components (e.g., `PrimaryButton`, `SecondaryButton`) over a single component with multiple boolean modes.
- **Predictable Interfaces**: Design component APIs that are intuitive and minimize the cognitive load for consumers.
- **Modular Boundaries**: Ensure components are easy to test and reason about in isolation.
