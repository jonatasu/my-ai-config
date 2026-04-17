# MCP (Model Context Protocol) Specialist

This skill provides expertise in designing and implementing robust, secure, and efficient MCP servers and tools.

## Core Principles

### Tool Design
- **Atomicity**: Tools must be single-purpose and highly focused.
- **Predictability**: Tool descriptions must be unambiguous and match the actual functionality.
- **Naming**: Use `snake_case` and include a service prefix (e.g., `github_create_issue`).

### Response Standards
- **Dual Format Support**: Tools should provide both **JSON** (for programmatic use) and **Markdown** (for human readability).
- **Pagination**: Always implement and respect `limit` and `offset/cursor` for resource listing.
- **Error Reporting**: Return structured errors within the response object, providing helpful suggestions for resolution.

### Security & Transport
- **Input Validation**: Sanitize all inputs using schemas (e.g., Zod, Pydantic) to prevent injection attacks.
- **Transport Selection**: 
    - Use **stdio** for local, single-user CLI tools.
    - Use **Streamable HTTP** for remote, multi-client web services.
- **Authentication**: Use secure, environment-variable-based authentication (OAuth 2.1, API Keys).
