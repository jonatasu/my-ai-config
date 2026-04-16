---
name: testing
description: Testing guidelines, patterns, and TestSprite MCP usage for automated test generation
---

## Testing Principles

- Write tests for new features and bug fixes
- Follow the AAA pattern: Arrange, Act, Assert
- Test edge cases and error scenarios
- Keep tests focused and independent
- Use descriptive test names that explain the scenario
- Prefer integration tests for critical paths
- Mock external dependencies, not internal modules
- Aim for confidence, not coverage percentage

## Test Naming Convention

```
describe('ComponentName', () => {
  describe('methodName', () => {
    it('should [expected behavior] when [condition]', () => {
      // test
    });
  });
});
```

## What to Test

### Always Test
- Happy path scenarios
- Edge cases (empty, null, undefined, boundary values)
- Error scenarios and exception handling
- User input validation
- State transitions
- API contracts

### Consider Testing
- Race conditions
- Timeout scenarios
- Concurrent operations
- Memory usage for large datasets

## Using TestSprite MCP

TestSprite automatically generates and executes tests. Use it for:

### When to Use TestSprite
- Generating initial test suite for new code
- Adding tests to legacy code without tests
- Creating comprehensive test coverage quickly
- Getting fix suggestions for failing tests

### TestSprite Workflow
1. Point TestSprite to the code to test
2. It analyzes code structure
3. Generates test plan
4. Creates test code
5. Executes tests in cloud
6. Provides results and fix suggestions

### Supported Technologies
- Frontend: React, Vue, Angular, Svelte, Next.js
- Backend: Node.js, Python, Java, Go
- Frameworks: Express, FastAPI, Spring Boot
- APIs: REST APIs

## Test Structure

```typescript
describe('UserService', () => {
  // Arrange - setup that applies to all tests
  let service: UserService;
  
  beforeEach(() => {
    service = new UserService();
  });

  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // Arrange
      const userData = { name: 'John', email: 'john@example.com' };
      
      // Act
      const result = await service.createUser(userData);
      
      // Assert
      expect(result.id).toBeDefined();
      expect(result.name).toBe('John');
    });

    it('should throw error when email is invalid', async () => {
      // Arrange
      const userData = { name: 'John', email: 'invalid' };
      
      // Act & Assert
      await expect(service.createUser(userData)).rejects.toThrow('Invalid email');
    });
  });
});
```

## Mocking Guidelines

- Mock external services (APIs, databases, file system)
- Don't mock the code under test
- Use dependency injection to make mocking easier
- Prefer fake implementations over mocks when possible
- Reset mocks between tests
