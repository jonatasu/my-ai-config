---
name: performance
description: Performance optimization techniques, profiling strategies, and common bottlenecks
---

## Performance Analysis Process

1. **Measure first** - Don't optimize blindly
2. **Identify bottleneck** - Find the slowest part
3. **Optimize** - Fix the bottleneck
4. **Measure again** - Verify improvement
5. **Repeat** if needed

## Common Bottlenecks

### Algorithm Complexity

| Complexity | Name | Example |
|------------|------|---------|
| O(1) | Constant | Hash table lookup |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Array iteration |
| O(n log n) | Linearithmic | Good sorting |
| O(n²) | Quadratic | Nested loops |
| O(2ⁿ) | Exponential | Naive recursion |

### Database Queries

#### N+1 Problem
```typescript
// BAD - N+1 queries
const users = await User.findAll();
for (const user of users) {
  const posts = await Post.findAll({ where: { userId: user.id } });
}

// GOOD - Single query with join/include
const users = await User.findAll({
  include: [{ model: Post }]
});
```

#### Missing Indexes
```sql
-- Add indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_id ON posts(user_id);
```

#### Select Only Needed Columns
```typescript
// BAD
SELECT * FROM users;

// GOOD
SELECT id, name, email FROM users;
```

### Frontend Performance

#### Bundle Size
- Code splitting / lazy loading
- Tree shaking unused code
- Compress assets (gzip/brotli)

#### Rendering
- Virtualize long lists
- Debounce/throttle event handlers
- Memoize expensive computations
- Avoid layout thrashing

#### Network
- Cache API responses
- Use CDN for static assets
- Preload critical resources

### Memory Leaks

```typescript
// Common causes:
// 1. Event listeners not removed
element.addEventListener('click', handler);
// Fix: element.removeEventListener('click', handler);

// 2. Timers not cleared
const id = setInterval(fn, 1000);
// Fix: clearInterval(id);

// 3. Closures holding references
function createHandler(largeData) {
  return () => console.log(largeData); // largeData never GC'd
}
```

### Async Operations

```typescript
// BAD - Sequential requests
const user = await getUser(id);
const posts = await getPosts(id);
const comments = await getComments(id);

// GOOD - Parallel requests
const [user, posts, comments] = await Promise.all([
  getUser(id),
  getPosts(id),
  getComments(id)
]);
```

## Caching Strategies

| Strategy | Use Case |
|----------|----------|
| In-memory | Frequently accessed, small data |
| Redis | Shared cache across instances |
| HTTP cache | Static assets, API responses |
| Memoization | Pure function results |

```typescript
// Simple memoization
function memoize<T>(fn: (...args: any[]) => T): (...args: any[]) => T {
  const cache = new Map();
  return (...args) => {
    const key = JSON.stringify(args);
    if (!cache.has(key)) {
      cache.set(key, fn(...args));
    }
    return cache.get(key);
  };
}
```

## Profiling Tools

| Tool | Purpose |
|------|---------|
| Chrome DevTools Performance | Frontend profiling |
| Lighthouse | Web vitals, best practices |
| Node --inspect | Node.js profiling |
| Database EXPLAIN | Query analysis |

## Output Format

```
### Performance Issue

**Location**: path/to/file.ts:42
**Current**: O(n²) / 500ms / 100MB
**Proposed**: O(n) / 50ms / 10MB
**Impact**: 10x faster, 90% less memory

**Before**:
[code snippet]

**After**:
[optimized code snippet]

**Benchmark**:
- Before: Xms
- After: Yms
- Improvement: Z%
```
