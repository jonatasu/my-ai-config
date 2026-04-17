# Documentation & Communication Standards

This document defines how technical knowledge is captured, organized, and communicated.

## 1. Documentation as Code (DaC)

Documentation is a first-class citizen of the codebase and must follow the same lifecycle as code.

- **Location**: All documentation must reside in the repository (e.g., `docs/`, `README.md`, `CHANGELOG.md`).
- **Format**: Use Markdown for all documentation.
- **Lifecycle**: Documentation must be updated alongside code changes via the same Pull Request process.
- **Single Source of Truth (SSoT)**: Avoid duplicating information. If a piece of information (like an API endpoint) is defined in the code, the documentation should reference it rather than re-typing it.

## 2. Documentation Structure

Maintain a consistent hierarchy for technical information:

- **README.md**: The entry point. Should contain project purpose, quick start, and high-level architecture.
- **Architecture Decision Records (ADRs)**: Capture the "why" behind significant technical decisions.
- **API Documentation**: Clear, structured documentation of endpoints, request/response formats, and authentication.
- **User Guides / Tutorials**: Step-by-step instructions for common tasks.
- **Changelogs**: A chronological record of all notable changes, organized by version or date.

## 3. Writing Style

- **Clarity over Cleverness**: Write for humans. Use simple, direct language.
- **Action-Oriented**: Use active verbs (e.g., "Run `npm install`" instead of "The installation should be run").
- **Precision**: Be specific. Instead of "the file", use "the `config/settings.json` file".
- **Consistency**: Use the same terminology throughout the documentation.
