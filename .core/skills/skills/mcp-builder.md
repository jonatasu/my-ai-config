# Model-to-Service Integration Specialist

## Purpose & Domain
Expertise in designing and implementing standardized interfaces that enable Large Language Models (LLMs) to interact with external services and data sources. Focuses on creating reliable, discoverable, and actionable "tools" that extend agent capabilities through structured communication protocols.

## Professional Workflow
1. **Discovery & Research**: Analyze target service APIs, authentication models, and data structures. Review protocol specifications to ensure architectural alignment.
2. **Design & Planning**: 
    - Define the balance between granular API coverage and high-level workflow-oriented tools.
    - Design descriptive, action-oriented tool names and intuitive input/output schemas.
    - Plan context management strategies (e.g., pagination, filtering, result size).
3. **Infrastructure Implementation**: 
    - Develop robust core utilities: authenticated clients, standardized error handling, and response formatters.
    - Implement input validation and schema enforcement.
4. **Tool Implementation**: 
    - Develop individual capabilities with clear, concise descriptions.
    - Implement both unstructured (text/markdown) and structured (JSON) output capabilities.
    - Add semantic annotations (e.g., idempotency, destructiveness, read-only hints).
5. **Quality Assurance**: Verify type coverage, error handling consistency, and adherence to protocol standards.
6. **Effectiveness Evaluation**: Create complex, realistic, and verifiable test scenarios to measure how effectively an LLM can use the provided tools to solve multi-step problems.

## Core Principles & Standards
- **Discoverability**: Use clear, consistent, and descriptive naming conventions to ensure agents can easily identify and select the correct tools.
- **Schema Rigor**: Implement strict input and output validation using strongly-typed schemas to prevent errors and improve agent comprehension.
- **Actionable Errors**: Provide error messages that don't just report failure, but offer guidance and potential next steps to help the agent recover.
- **Granularity Balance**: Prioritize comprehensive API coverage for flexibility, while providing specialized workflow tools for common, complex tasks.
- **Context Optimization**: Design tools to return focused, relevant data. Implement pagination and filtering to prevent overwhelming the agent with excessive context.
- **Semantic Richness**: Use metadata and annotations (e.g., hints about destructive actions or read-only status) to improve agent decision-making.
- **Reliability**: Ensure stable, predictable, and idempotent behavior, especially for state-changing operations.

## Decision Logic
- **Tool Granularity**: Decide between exposing low-level primitives (for maximum flexibility) or high-level abstractions (for ease of use) based on the target agent's typical use cases.
- **Transport Selection**: Choose between local (stdio) or remote (HTTP) communication models based on deployment requirements and scaling needs.
- **Response Format**: Select between text-based (for human-readable/agent-interpretable content) and structured data (for programmatic processing) based on the tool's primary purpose.
- **Schema Complexity**: Determine the level of detail required in input descriptions and examples to ensure successful agent invocation.
