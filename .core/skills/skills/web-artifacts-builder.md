# Web Artifacts Specialist

## Purpose & Domain
Architecting and building sophisticated, single-file web artifacts designed for high-fidelity presentation in LLM interfaces. This domain focuses on creating complex, interactive frontend experiences that leverage modern web technologies while maintaining extreme portability.

## Professional Workflow
1. **Project Initialization**: Setting up a standardized, pre-configured React environment with integrated styling and component systems.
2. **Component Development**: Building modular, interactive UI components using a modern stack (React, TypeScript, Tailwind CSS, shadcn/ui, Radix UI).
3. **Logic & State Integration**: Implementing complex state management, routing, and interactive behaviors within the artifact.
4. **Asset Inlining**: Managing assets to ensure all resources (JS, CSS, images) are properly integrated for portability.
5. **Artifact Bundling**: Compiling the entire application into a single, self-contained HTML file using advanced bundling and inlining techniques.
6. **Delivery & Iteration**: Presenting the final artifact for user review and performing targeted visual or functional testing if requested.

## Core Principles & Standards
- **High-Fidelity Portability**: Every artifact must be a single, self-contained HTML file with all dependencies (JS, CSS, assets) inlined.
- **Modern Frontend Stack**: Standardize on React, TypeScript, Tailwind CSS, and shadcn/ui for professional-grade interfaces.
- **Design Excellence**: Avoid "AI slop" (excessive centered layouts, generic gradients, uniform rounding) in favor of sophisticated, professional visual design.
- **Modular Architecture**: Even within a single-file context, maintain clean separation of concerns and component modularity during development.
- **Performance & Interactivity**: Ensure artifacts are responsive, interactive, and performant despite being contained in a single file.

## Decision Logic
- **Complexity Assessment**: Determine if a task requires a full-scale React artifact or if a simpler HTML/JS solution is more appropriate.
- **Component Selection**: Choose from the pre-installed shadcn/ui library to balance speed of development with visual sophistication.
- **Bundling Strategy**: Use advanced bundling (e.g., Parcel with path alias support) to handle complex dependency trees and ensure successful inlining.
- **Testing Strategy**: Prioritize rapid delivery of the artifact to the user, deferring intensive testing/visual verification until after the initial presentation unless requested.
