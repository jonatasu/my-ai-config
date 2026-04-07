---
name: documentation
description: Documentation best practices, API docs, README templates, and JSDoc/TSDoc patterns
---

## Documentation Principles

- Write for the reader, not yourself
- Keep it up to date with code changes
- Use examples liberally
- Document the "why", not just the "what"
- All documentation in English

## README Template

```markdown
# Project Name

Brief description of what this project does.

## Features

- Feature 1
- Feature 2

## Installation

\`\`\`bash
npm install package-name
\`\`\`

## Quick Start

\`\`\`typescript
import { something } from 'package-name';

// Basic usage example
const result = something();
\`\`\`

## API Reference

### `functionName(param1, param2)`

Description of what the function does.

**Parameters:**
- `param1` (string): Description
- `param2` (number, optional): Description. Default: `10`

**Returns:** `ReturnType` - Description

**Example:**
\`\`\`typescript
const result = functionName('value', 20);
\`\`\`

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `option1` | string | `'default'` | What it does |
| `option2` | boolean | `false` | What it does |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

MIT
```

## JSDoc/TSDoc Patterns

### Function Documentation

```typescript
/**
 * Calculates the total price including tax.
 *
 * @param price - The base price before tax
 * @param taxRate - Tax rate as decimal (e.g., 0.1 for 10%)
 * @returns The total price with tax applied
 *
 * @example
 * ```ts
 * calculateTotal(100, 0.1); // Returns 110
 * ```
 *
 * @throws {Error} If price is negative
 */
function calculateTotal(price: number, taxRate: number): number {
  if (price < 0) throw new Error('Price cannot be negative');
  return price * (1 + taxRate);
}
```

### Interface Documentation

```typescript
/**
 * Configuration options for the API client.
 */
interface ApiClientConfig {
  /** Base URL for all API requests */
  baseUrl: string;

  /** Request timeout in milliseconds. @default 5000 */
  timeout?: number;

  /** Custom headers to include in every request */
  headers?: Record<string, string>;

  /**
   * Retry configuration for failed requests.
   * Set to `false` to disable retries.
   */
  retry?: RetryConfig | false;
}
```

### Class Documentation

```typescript
/**
 * HTTP client for making API requests.
 *
 * @example
 * ```ts
 * const client = new ApiClient({ baseUrl: 'https://api.example.com' });
 * const users = await client.get<User[]>('/users');
 * ```
 */
class ApiClient {
  /**
   * Creates a new API client instance.
   * @param config - Client configuration options
   */
  constructor(config: ApiClientConfig) { ... }

  /**
   * Performs a GET request.
   * @typeParam T - Expected response type
   * @param path - API endpoint path
   * @returns Promise resolving to the response data
   */
  async get<T>(path: string): Promise<T> { ... }
}
```

## API Documentation

### Endpoint Documentation

```markdown
## POST /api/users

Creates a new user.

### Request

**Headers:**
- `Authorization: Bearer <token>` (required)
- `Content-Type: application/json`

**Body:**
\`\`\`json
{
  "name": "John Doe",
  "email": "john@example.com",
  "role": "user"
}
\`\`\`

### Response

**Success (201 Created):**
\`\`\`json
{
  "id": "123",
  "name": "John Doe",
  "email": "john@example.com",
  "role": "user",
  "createdAt": "2024-01-15T10:00:00Z"
}
\`\`\`

**Error (400 Bad Request):**
\`\`\`json
{
  "error": "Validation failed",
  "details": [
    { "field": "email", "message": "Invalid email format" }
  ]
}
\`\`\`
```

## When NOT to Document

- Obvious getter/setter methods
- Self-explanatory function names with clear types
- Internal/private implementation details
- Anything the types already explain clearly

```typescript
// No doc needed - types and name are clear
function getUserById(id: string): Promise<User | null>

// Doc needed - behavior not obvious from signature
/**
 * Fetches user with related posts and comments.
 * Results are cached for 5 minutes.
 */
function getUserWithDetails(id: string): Promise<UserDetails>
```
