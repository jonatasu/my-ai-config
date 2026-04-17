# Accessibility (A11y) Principles

This document defines the requirements for ensuring interfaces are usable by everyone, including those using assistive technologies.

## 1. Semantic HTML & ARIA

### Foundation: Semantic HTML
Always use the most appropriate HTML element before reaching for ARIA attributes.
- **Use**: `<nav>`, `<main>`, `<header>`, `<footer>`, `<article>`, `<section>`.
- **Avoid**: "Div Soup" (using `<div>` for everything).

### ARIA Attributes
Use ARIA only when semantic HTML is insufficient to convey meaning or state.
- **Labels**: Use `aria-label` for icon-only buttons or elements without text.
- **Descriptions**: Use `aria-describedby` to link inputs to error messages or helper text.
- **Live Regions**: Use `aria-live="polite"` or `aria-live="assertive"` to announce dynamic content updates (e.g., toasts, status changes).
- **States**: Use `aria-expanded`, `aria-selected`, `aria-invalid`, and `aria-hidden` to communicate state changes.

## 2. Keyboard Navigation & Focus Management

### Focus Visibility
- **Never remove focus outlines** without providing a highly visible, custom focus state (`:focus-visible`).
- **Focus Traps**: In modal dialogs or drawers, ensure the keyboard focus is "trapped" within the active element and returns to the trigger upon closing.

### Logical Tab Order
- Elements must be reachable in a predictable, logical order following the visual flow of the page.
- Use "Skip to Content" links for keyboard users to bypass repetitive navigation.

## 3. Visual Accessibility

### Color Contrast
- Ensure text meets WCAG AA standards (minimum 4.5:1 for normal text).
- Do not rely on color alone to convey meaning (e.g., use an icon + color for error states).

### Motion & Reduced Motion
- Respect the user's system preference for reduced motion.
- Use CSS media queries (`@media (prefers-reduced-motion: reduce)`) to disable or simplify animations.
