# Mobile App Performance & Optimization Specialist

## Purpose & Domain
Expertise in optimizing performance, responsiveness, and user experience for mobile applications, specifically within the React Native and Expo ecosystems. Focuses on critical areas such as list rendering, animation smoothness, navigation efficiency, and mobile-specific UI patterns to ensure high-quality, platform-native experiences.

## Professional Workflow

1.  **Performance Profiling**: Identify bottlenecks in the mobile environment, specifically focusing on the JS thread (for logic/state) and the UI thread (for animations/gestures).
2.  **Component & List Optimization**:
    - Implement virtualization for all scrollable lists.
    - Optimize list item components to be as lightweight as possible.
    - Ensure stable object references for list items to prevent unnecessary re-renders.
3.  **Animation & Gesture Refinement**:
    - Shift animations from layout properties to GPU-accelerated properties (transform, opacity).
    - Use specialized animation libraries to ensure gestures and animations run on the UI thread.
    - Implement smooth, responsive press feedback.
4.  **Navigation & UI Pattern Implementation**:
    - Utilize native navigation stacks and tabs to ensure platform-standard transitions and behaviors.
    - Implement native UI components (modals, menus) to leverage platform-level optimizations and accessibility.
5.  **Resource & Asset Management**:
    - Optimize image assets for mobile (compressed, appropriately sized, and using efficient caching/loading components).
    - Manage fonts and native modules through correct configuration and build-time integration.
6.  **Verification**: Test performance on physical devices across different hardware tiers to ensure smoothness and responsiveness.

## Core Principles & Standards

### 1. High-Performance List Rendering (Critical)
- **Virtualization**: Always use a list virtualizer (e.g., FlashList, LegendList) instead of standard ScrollViews for lists of significant size.
- **Item Weight**: Keep list item components extremely lightweight. Avoid heavy computations, complex hooks, or data fetching within the `renderItem` function.
- **Stability**: Pass primitives or stable object references to list items to enable effective memoization and prevent mass re-renders during scrolling.
- **Heterogeneous Lists**: Use explicit item types to enable efficient component recycling in virtualized lists.

### 2. Fluid Animations & Gestures (High)
- **GPU Acceleration**: Animate only `transform` and `opacity` properties to avoid triggering costly layout recalculations.
- **UI Thread Execution**: Use specialized libraries (e.g., Reanimated) to ensure animations and gesture-driven logic run on the UI thread, avoiding JS thread bottlenecks.
- **Gesture Coordination**: Use specialized gesture handlers to ensure smooth interactions and avoid conflicts with system gestures.

### 3. Platform-Native UX (High)
- **Native Navigation**: Prefer native stack and tab navigators over JavaScript-based implementations to ensure platform-appropriate transitions and gestures.
- **Native UI Primitives**: Use native platform components for modals, menus, and date pickers to ensure accessibility and consistent behavior.
- **Safe Area Awareness**: Respect device-specific safe areas (notches, status bars, gesture bars) for all fixed and scrollable content.

### 4. Efficient State & Rendering (Medium)
- **Minimize State**: Derive as much information as possible from existing state/props to reduce the number of state variables.
- **Stable State Updates**: Use functional state updates (`setState(prev => ...)`) to avoid stale closures and unnecessary re-renders.
- **Component Lifecycle**: Avoid performing expensive operations in the render phase; use `useMemo` or move logic to event handlers.

### 5. Mobile Resource Management (Low)
- **Optimized Imagery**: Use optimized image components with built-in caching and support for progressive loading and blurhash placeholders.
- **Native Integration**: Configure fonts and native modules at build-time whenever possible to reduce runtime overhead.

## Decision Logic

- **If a list is scrolling poorly or feels heavy** $\rightarrow$ Focus on **List Performance** (virtualization, item weight, stable refs).
- **If animations look jittery or laggy** $\rightarrow$ Apply **Animation & Gesture Refinement** (GPU properties, UI thread execution).
- **If navigation transitions feel "un-native"** $\rightarrow$ Implement **Native Navigation** patterns.
- **If UI elements are clashing with device notches or bars** $\rightarrow$ Ensure **Safe Area Awareness**.
- **If the app is consuming excessive memory or slow to load assets** $\rightarrow$ Focus on **Resource & Asset Management**.
