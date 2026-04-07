---
name: refactoring
description: Code refactoring patterns, techniques, and best practices for improving code quality
---

## Refactoring Principles

- **Never refactor and change behavior at the same time**
- Make small, incremental changes
- Run tests after each change
- Commit frequently

## When to Refactor

- Before adding new features to messy code
- After getting tests passing (Red-Green-Refactor)
- When you see code smells
- During code review
- When cyclomatic complexity > 5

## Common Code Smells

### Functions
| Smell | Solution |
|-------|----------|
| Long function (>30 lines) | Extract smaller functions |
| Too many parameters (>4) | Use parameter object |
| Deep nesting (>3 levels) | Extract functions, use early returns |
| Duplicate code | Extract to shared function |

### Classes/Modules
| Smell | Solution |
|-------|----------|
| Large class | Split by responsibility |
| Feature envy | Move method to the class it uses most |
| Data clumps | Create a class for the data |
| Primitive obsession | Create domain types |

### General
| Smell | Solution |
|-------|----------|
| Magic numbers/strings | Extract to named constants |
| Dead code | Delete it |
| Comments explaining what | Rename or restructure code |
| Inconsistent naming | Rename for consistency |

## Refactoring Techniques

### Extract Function
```typescript
// Before
function processOrder(order) {
  // validate
  if (!order.items || order.items.length === 0) {
    throw new Error('Empty order');
  }
  if (!order.customer) {
    throw new Error('No customer');
  }
  // ... rest of processing
}

// After
function processOrder(order) {
  validateOrder(order);
  // ... rest of processing
}

function validateOrder(order) {
  if (!order.items || order.items.length === 0) {
    throw new Error('Empty order');
  }
  if (!order.customer) {
    throw new Error('No customer');
  }
}
```

### Replace Nested Conditionals with Guard Clauses
```typescript
// Before
function getPayAmount(employee) {
  let result;
  if (employee.isSeparated) {
    result = { amount: 0, reason: 'separated' };
  } else {
    if (employee.isRetired) {
      result = { amount: 0, reason: 'retired' };
    } else {
      result = calculatePay(employee);
    }
  }
  return result;
}

// After
function getPayAmount(employee) {
  if (employee.isSeparated) return { amount: 0, reason: 'separated' };
  if (employee.isRetired) return { amount: 0, reason: 'retired' };
  return calculatePay(employee);
}
```

### Replace Magic Values with Constants
```typescript
// Before
if (user.role === 1) { ... }
setTimeout(fn, 86400000);

// After
const ADMIN_ROLE = 1;
const ONE_DAY_MS = 24 * 60 * 60 * 1000;

if (user.role === ADMIN_ROLE) { ... }
setTimeout(fn, ONE_DAY_MS);
```

### Introduce Parameter Object
```typescript
// Before
function createUser(name, email, age, country, city, zip) { ... }

// After
interface CreateUserParams {
  name: string;
  email: string;
  age: number;
  address: {
    country: string;
    city: string;
    zip: string;
  };
}

function createUser(params: CreateUserParams) { ... }
```

## Refactoring Workflow

1. **Ensure tests exist** - Add tests if missing
2. **Run tests** - Confirm they pass
3. **Make one small change**
4. **Run tests again** - Confirm still passing
5. **Commit** - Small, focused commit
6. **Repeat** until done
