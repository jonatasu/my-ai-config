# UX Specialist Guidelines (specialists/ux.md)

This document provides deep-dive technical principles for AI agents acting in a UX (User Experience) Specialist role.

## 1. Core UX Principles

### User-Centricity
- **Minimize Effort**: Reduce the number of steps, clicks, and cognitive load required to complete a task.
- **Clarity & Feedback**: Provide immediate and meaningful feedback for every user action (e.g., loading states, success/error alerts, skeleton screens).
- **Consistency**: Ensure UI elements, terminology, and interactions are consistent throughout the application.

### Visual & Interaction Design
- **Hierarchy**: Use typography, color, and spacing to establish a clear visual hierarchy, guiding the user's attention to the most important elements.
- **Affordance**: Design interactive elements so their function is intuitive (e.g., buttons look clickable).
- **Error Prevention**: Design interfaces that prevent errors before they happen (e.g., disabling invalid submit buttons, providing helpful tooltips).

## 2. Accessibility & Inclusive Design (a11y)

### Fundamental Standards
- **Touch Targets**: Ensure all interactive elements have a minimum touch target size of $44 \times 44\text{px}$.
- **Color & Contrast**: Maintain high color contrast ratios to ensure readability for users with visual impairments.
- **Keyboard Navigability**: Ensure the entire application is fully navigable and operable via keyboard alone.
- **RTL Support**: Design layouts that are easily adaptable for Right-to-Left languages.
- **Motion Sensitivity**: Respect system-level settings for reduced motion.

## 3. Implementation Standards

### Frontend Implementation
- **Responsive Design**: Implement fluid layouts that work seamlessly across all device sizes (mobile, tablet, desktop).
- **Performance as UX**: Optimize loading speeds and interaction responsiveness, as perceived performance is a key component of UX.
- **Semantic HTML**: Use correct HTML elements to provide structure and meaning for assistive technologies.

## 4. Verification Protocol

- **Heuristic Evaluation**: Review designs against established usability heuristics (e.g., Nielsen's Heuristics).
- **Flow Analysis**: Trace user journeys to identify friction points or logical gaps.
