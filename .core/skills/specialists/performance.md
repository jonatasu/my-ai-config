# Performance Specialist Guidelines (specialists/performance.md)

This document provides deep-dive technical principles for AI agents acting in a Performance Engineering role.

## 1. Core Performance Principles

### User-Perceived Performance
- **Critical Path Optimization**: Prioritize the loading and execution of resources required for the "Above the Fold" content and core user interactions.
- **Perceived Speed**: Use techniques like skeleton screens, optimistic UI updates, and progressive loading to make the application feel faster, even when background tasks are ongoing.
- **Core Web Vitals (CWV)**: Target optimal scores for LCP (Largest Contentful Paint), FID/INP (First Input Delay/Interaction to Next Paint), and CLS (Cumulative Layout Shift).

### Resource & Execution Efficiency
- **Eliminate Waterfalls**: Prevent sequential loading of dependent resources. Use parallelization (e.g., `Promise.all`) and resource hints (`preload`, `prefetch`, `preconnect`) to optimize the loading sequence.
- **Bundle Optimization**: Minimize JavaScript bundle sizes through effective tree shaking, code splitting (dynamic imports), and avoiding large, monolithic libraries or "barrel files".
- **Memory Management**: Identify and mitigate memory leaks, especially in long-running single-page applications (SPAs). Ensure proper cleanup of event listeners, timers, and subscriptions.

## 2. Implementation Standards

### Frontend Optimization
- **Image & Media**: Use modern, highly compressed formats (WebP, AVIF), implement responsive images (`srcset`), and leverage lazy loading for off-screen media.
- **CSS Efficiency**: Minimize CSS complexity; avoid expensive selector nesting and unnecessary layout recalculations. Use logical properties for better layout performance.
- **Efficient Rendering**: Optimize component re-renders (e.g., using `memo`, `useMemo`, `useCallback` in React) and avoid heavy computations on the main thread.

### Backend & Network Optimization
- **Data Transfer**: Minimize payload sizes using compression (Gzip, Brotli) and efficient data formats (JSON, Protobuf).
- **Caching Strategy**: Implement robust caching at multiple levels (Browser, CDN, Server-side/Redis).
- **Database Performance**: Optimize queries, use appropriate indexing, and avoid N+1 query problems.

## 3. Verification Protocol

- **Profiling**: Use browser DevTools (Performance/Memory tabs) and server-side profilers to identify bottlenecks.
- **Automated Benchmarking**: Integrate performance testing into the CI/CD pipeline (e.g., Lighthouse CI).
- **Real User Monitoring (RUM)**: Analyze real-world performance data to identify issues affecting actual users.
