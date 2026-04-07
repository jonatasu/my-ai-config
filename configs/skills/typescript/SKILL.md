---
name: typescript
description: TypeScript best practices, type patterns, and strict typing guidelines
---

## TypeScript Principles

- Enable `strict` mode in tsconfig
- Avoid `any` - use `unknown` if type is truly unknown
- Prefer interfaces for object shapes, types for unions/intersections
- Use generics for reusable type-safe code
- Let TypeScript infer when obvious

## Strict Mode Settings

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitReturns": true,
    "noUncheckedIndexedAccess": true
  }
}
```

## Common Patterns

### Avoid `any`

```typescript
// BAD
function process(data: any) { ... }

// GOOD - Use specific type
function process(data: UserData) { ... }

// GOOD - Use unknown + type guard
function process(data: unknown) {
  if (isUserData(data)) {
    // data is UserData here
  }
}
```

### Type Guards

```typescript
// Type predicate
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

// Discriminated union
type Result<T> = 
  | { success: true; data: T }
  | { success: false; error: string };

function handleResult<T>(result: Result<T>) {
  if (result.success) {
    console.log(result.data); // T
  } else {
    console.log(result.error); // string
  }
}
```

### Utility Types

```typescript
// Partial - all properties optional
type PartialUser = Partial<User>;

// Required - all properties required
type RequiredUser = Required<User>;

// Pick - select properties
type UserName = Pick<User, 'firstName' | 'lastName'>;

// Omit - exclude properties
type UserWithoutPassword = Omit<User, 'password'>;

// Record - dictionary type
type UserMap = Record<string, User>;

// ReturnType - function return type
type FnReturn = ReturnType<typeof someFunction>;

// Parameters - function parameters
type FnParams = Parameters<typeof someFunction>;
```

### Generics

```typescript
// Generic function
function first<T>(arr: T[]): T | undefined {
  return arr[0];
}

// Generic with constraints
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

// Generic interface
interface Repository<T> {
  find(id: string): Promise<T | null>;
  save(entity: T): Promise<T>;
  delete(id: string): Promise<void>;
}
```

### Branded Types

```typescript
// Prevent mixing up similar types
type UserId = string & { readonly brand: unique symbol };
type PostId = string & { readonly brand: unique symbol };

function createUserId(id: string): UserId {
  return id as UserId;
}

function getUser(id: UserId) { ... }
function getPost(id: PostId) { ... }

const userId = createUserId('123');
getUser(userId); // OK
getPost(userId); // Error!
```

### Const Assertions

```typescript
// Literal types
const config = {
  endpoint: '/api',
  timeout: 5000
} as const;
// typeof config.endpoint is '/api', not string

// Tuple types
const tuple = [1, 'hello'] as const;
// typeof tuple is readonly [1, 'hello']
```

### Template Literal Types

```typescript
type EventName = 'click' | 'focus' | 'blur';
type Handler = `on${Capitalize<EventName>}`;
// 'onClick' | 'onFocus' | 'onBlur'
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `any` everywhere | Use proper types or `unknown` |
| `!` non-null assertion | Use proper null checks |
| Ignoring errors with `// @ts-ignore` | Fix the type error |
| `as` type assertion abuse | Use type guards |
| Not using strict mode | Enable all strict options |

## API Response Typing

```typescript
// Define API response types
interface ApiResponse<T> {
  data: T;
  meta: {
    page: number;
    total: number;
  };
}

interface User {
  id: string;
  name: string;
  email: string;
}

// Type the fetch
async function getUsers(): Promise<ApiResponse<User[]>> {
  const response = await fetch('/api/users');
  return response.json();
}
```
