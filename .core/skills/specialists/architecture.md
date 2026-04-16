# Architecture Specialist Guidelines (specialists/architecture.md)

This document provides deep-dive technical principles for AI agents acting in a Software Architect role.

## 1. Core Architectural Principles

### Structural Integrity
- **Separation of Concerns**: Maintain strict boundaries between different layers of the application (e.g., Presentation, Business Logic, Data Access).
- **High Cohesion & Low Coupling**: Ensure modules/components are highly focused on a single responsibility and have minimal dependencies on other modules.
- **Single Responsibility Principle (SRP)**: Every class, function, or component should have one, and only one, reason to change.

### Scalability & Maintainability
- **Design for Change**: Use abstractions and interfaces to protect the system from changes in external dependencies or implementation details.
- **Pattern Selection**: Choose architectural patterns (e.g., Microservices, Layered, Hexagonal, Event-Driven) that align with the project's scale and complexity requirements.
- **Avoid Premature Optimization**: Build for current needs while keeping scalability in mind, avoiding overly complex abstractions before they are necessary.

## 2. Design Patterns & Best Practices

### Patterns to Favor
- **Dependency Injection**: Use DI to manage dependencies and improve testability.
- **Repository Pattern**: Decouple business logic from data access implementations.
- **Command/Query Responsibility Segregation (CQRS)**: Separate read and write operations for complex domain models.
- **Observer/Event Bus**: Use for decoupled communication between components.

### Complexity Management
- **Cyclomatic Complexity**: Proactively identify and refactor overly complex code paths.
- **Abstractions**: Use abstractions to hide implementation details, but avoid "leaky abstractions" that expose underlying complexities.

## 3. Implementation Standards

### Documentation & Modeling
- **Architectural Decision Records (ADRs)**: Document significant architectural decisions, including the context, alternatives considered, and the rationale for the chosen path.
- **Diagramming**: Use visual representations (e.g., UML, C4 model) to communicate complex structures and flows.

## 4. Verification Protocol

- **Structural Analysis**: Review the codebase to ensure adherence to the defined architectural layers and patterns.
- **Dependency Audit**: Identify and mitigate circular dependencies and tightly coupled modules.
- **Review for Complexity**: Evaluate the impact of new changes on the system's overall complexity and maintainability.
