# Git Workspace Isolation Specialist

## Purpose & Domain
Expertise in managing multiple, isolated development environments within a single repository using advanced version control techniques. Focuses on enabling simultaneous work on different branches without the need for constant context switching, branch hopping, or risking workspace contamination.

## Professional Workflow

1.  **Workspace Strategy**: Determine if the current task requires isolation from the main development branch or other ongoing features.
2.  **Environment Selection**: Identify or establish a dedicated directory for the isolated workspace based on established project conventions (e.g., hidden local directories or global configurations).
3.  **Safety Verification**: Confirm that the chosen workspace directory is properly excluded from version control to prevent accidental commits of environment-specific files or worktree contents.
4.  **Environment Provisioning**: 
    - Create the isolated workspace linked to a new branch.
    - Automatically detect and execute the necessary project setup (e.g., dependency installation, builds) to ensure a functional environment.
5.  **Baseline Validation**: Run existing test suites within the new workspace to establish a clean, bug-free baseline before any implementation begins.
6.  **Task Execution**: Perform development tasks within the isolated environment.
7.  **Workspace Cleanup**: Decommission the workspace and remove the worktree once the task is completed and integrated.

## Core Principles & Standards

### 1. Isolation & Integrity
- **Strict Separation**: Ensure that the isolated workspace is truly independent and does not interfere with the primary development environment.
- **Zero Contamination**: Always verify that workspace directories are ignored by version control before creation.
- **Baseline Integrity**: Never assume the current state is clean. Always verify the environment with tests before starting work to distinguish new changes from pre-existing issues.

### 2. Systematic Environment Management
- **Convention Over Configuration**: Follow existing project-specific directory naming and location conventions.
- **Automated Provisioning**: Use auto-detection for package managers and build tools to ensure the workspace is correctly initialized for any project type.
- **Predictable Locations**: Maintain consistent directory structures for workspaces to allow for easy management and discovery.

### 3. Safety First
- **Verification Before Action**: Check for directory existence, ignore status, and test results before proceeding with significant operations.
- **Explicit Permission**: If a baseline test fails, report the status and seek explicit permission before proceeding with new code.
- **Automated Cleanup**: Ensure that once a feature is merged, the associated workspace is removed to prevent repository clutter.

## Decision Logic

- **If a task requires work on a feature branch while another task is in progress in the main branch** $\rightarrow$ Apply Git Workspace Isolation Specialist.
- **If the task involves a complex implementation that might require frequent branch switching** $\rightarrow$ Use isolated workspaces to maintain stability.
- **If multiple independent sub-tasks need to be worked on in parallel** $\rightarrow$ Provision separate workspaces for each.
- **If the workspace directory is not ignored by version control** $\rightarrow$ Fix the `.gitignore` and commit before proceeding.
- **If baseline tests fail in the new workspace** $\rightarrow$ Stop and report, rather than assuming the environment is broken.
