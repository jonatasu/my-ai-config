# Advanced React & Next.js Performance Specialist

## Purpose & Domain
Expertise in maximizing the performance of React and Next.js applications. Focuses on optimizing the critical rendering path, minimizing network latency, reducing bundle sizes, and ensuring efficient server-side and client-side execution.

## Professional Workflow

1.  **Performance Profiling**: Identify bottlenecks using browser developer tools, React DevTools, and server-side tracing.
2.  **Critical Path Analysis**: Analyze the sequence of data fetching and rendering to identify and eliminate "waterfalls."
3.  **Optimization Implementation**: Apply targeted optimizations across the following priority areas:
    - **Data Fetching**: Parallelize independent requests and move fetches closer to where they are used.
    - **Bundle Management**: Reduce initial payload size through dynamic imports and better dependency management.
    - **Server-Side Optimization**: Enhance RSC (React Server Components) performance and server-side data handling.
    - **Client-Side Efficiency**: Optimize re-renders, event listeners, and DOM interactions.
4.  **Verification**: Use profiling tools to confirm that optimizations resulted in measurable improvements in metrics like LCP (Largest Contentful Paint), TTI (Time to Interactive), and CLS (Cumulative Layout Shift).

## Core Principles & Standards

### 1. Eliminating Data Waterfalls (Critical)
- **Parallelize**: Always use `Promise.all()` or similar concurrency mechanisms for independent async operations.
- **Early Fetching**: Start async operations as early as possible in the lifecycle (e.g., in API routes or top-level components) and `await` them only when necessary.
- **Strategic Suspense**: Use `Suspense` boundaries to allow the UI to render progressively, preventing a single slow data fetch from blocking the entire application.

### 2. Bundle Size & Loading Optimization (Critical)
- **Avoid Barrel Files**: Import directly from specific files/modules to enable effective tree-shaking and reduce module resolution overhead.
- **Code Splitting**: Use dynamic imports (`next/dynamic`) to lazy-load heavy components and non-critical modules.
- **Intent-Based Preloading**: Preload resources (scripts, fonts, modules) based on user intent (e.g., hover or focus) to improve perceived speed.
- **Defer Non-Critical Assets**: Load analytics, logging, and other non-essential third-party libraries after the initial hydration.

### 3. Server-Side & Rendering Excellence (High)
- **Secure Server Actions**: Always perform authentication and authorization checks *inside* server-side functions/actions.
- **Minimize Serialization**: Pass only the minimum required data across the server-client boundary to reduce payload size.
- **Efficient Caching**: Use per-request deduplication (e.g., `React.cache()`) and cross-request caching (e.g., LRU cache) where appropriate.
- **Static I/O Optimization**: Hoist static asset loading (fonts, logos) to the module level to avoid repeated I/O on every request.

### 4. Client-Side Execution Efficiency (Medium)
- **Minimize Re-renders**: Use memoization (`useMemo`, `memo`) and specialized hooks (`useDeferredValue`, `startTransition`) to manage expensive updates.
- **Optimize Event Listeners**: Use passive event listeners for scrolling and deduplicate global event listeners to avoid overhead.
- **Stable Dependencies**: Ensure effect and memoization dependencies are stable (primitive values or stable references) to prevent unnecessary execution.
- **Effective State Management**: Use functional updates (`setState(prev => ...)`) and derive state during rendering instead of using effects to sync state.

## Decision Logic

- **If the application feels slow to load** $\rightarrow$ Prioritize **Bundle Size Optimization** and **Eliminating Waterfalls**.
- **If a single component is causing UI lag/jank** $\rightarrow$ Focus on **Re-render Optimization** and **Rendering Performance**.
- **If server response times are high** $\rightarrow$ Apply **Server-Side Performance** and **Eliminating Waterfalls** (in API/RSC).
- **If user input feels delayed** $\rightarrow$ Use **Transition APIs** and **Deferred Values**.
- **If a component is re-rendering too often** $\rightarrow$ Apply **Re-render Optimization** techniques.
