# Design Systems & Tokenization

This document defines the architecture for building scalable, themeable, and consistent visual interfaces.

## 1. Three-Layer Token Architecture

To enable easy theming (e.g., Dark Mode) and scalability, use a three-layer token system.

### Layer 1: Primitive Tokens (The "What")
Raw design values without semantic meaning.
- **Examples**: `--color-blue-500`, `--space-4`, `--font-size-lg`, `--radius-md`.
- **Usage**: Only used as the source for Semantic Tokens. Never used directly in components.

### Layer 2: Semantic Tokens (The "Why")
Purpose-based aliases that map to primitives. This is where theming happens.
- **Examples**: `--color-primary`, `--color-background`, `--spacing-section`, `--text-muted`.
- **Usage**: Used by components to define their visual identity.
- **Theming**: To implement Dark Mode, only the mapping from Semantic $\rightarrow$ Primitive needs to change.

### Layer 3: Component Tokens (The "Where")
Component-specific overrides for fine-grained control.
- **Examples**: `--button-bg`, `--card-padding`, `--input-border-color`.
- **Usage**: Used within specific component implementations to allow localized styling without affecting the global semantic layer.

## 2. Naming Conventions

Tokens should follow a hierarchical naming pattern:
`--{category}-{item}-{variant}-{state}`

**Examples:**
- `--color-primary` (category-item)
- `--color-primary-hover` (category-item-state)
- `--button-bg-active` (component-property-state)
- `--space-section-sm` (category-semantic-variant)
