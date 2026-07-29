# Agents Reference Guide

**Version:** 1.0  
**Last Updated:** 2026-07-29  
**Scope:** AI-Agnostic, Stack-Agnostic, Context-Independent Agent Specifications

This document provides a complete reference for all 17 agents in the Copilot ecosystem. Each agent is documented with its purpose, capabilities, domain specialization, and integration patterns, **independent of any specific AI model, development stack, or organizational context**.

### About JowCodes Specialists

The 12 JowCodes Specialists are **platform-agnostic domain experts**. They operate independently of any specific team, company, or project. They are named after experienced professionals but are replicable behavioral archetypes that work in any development environment, team structure, or organizational setting.

---

## Quick Reference

| Domain | Agents | Count |
|--------|--------|-------|
| JowCodes Specialists | jc-a11y, jc-android, jc-design-system, jc-devops, jc-docs, jc-ios, jc-mcp, jc-pm, jc-qa, jc-release, jc-sdui-architect, jc-security | 12 |
| Development Tools | dev-tools:skill-creator-agent | 1 |
| Caveman Specialists | caveman:cavecrew-builder, caveman:cavecrew-investigator, caveman:cavecrew-reviewer | 3 |
| Research & Documentation | context7:docs-researcher | 1 |

---

## JowCodes Specialists (12)

### Organization Context

These are 12 platform-agnostic domain specialists. They operate independently of any specific platform, team, or organizational context. They can be used in any development environment, project structure, or team configuration.

The specialists are named after experienced professionals with whom these behavioral archetypes originated, but the agents themselves are context-independent and replicable in any setting.

---

### 1. `jc-a11y` — Accessibility & WCAG Specialist
**Alias:** Cassiano

**Purpose:** Ensure JowCodes products meet WCAG 2.1/2.2 accessibility standards.

**Specialization Areas:**
- ARIA pattern implementation and review
- Keyboard navigation audits
- Screen reader compatibility testing
- Color contrast verification (WCAG AA/AAA)
- Focus management strategies
- Semantic HTML validation
- Testing across DH-DesignSystem and mobile apps

**Primary Repositories:**
- DH-DesignSystem (@lhgdesy/maui-components)
- lh-group-app-android
- lh-group-app-ios

**Input Capabilities:**
- Component code (Lit/React/Compose/SwiftUI)
- Design specifications
- User journey flows
- Accessibility requirement documents

**Output Deliverables:**
- ARIA compliance reports
- Accessibility audit findings
- Remediation recommendations
- Test case specifications

**Coordination Partners:**
- jc-design-system (component implementation)
- jc-android (Android-specific a11y)
- jc-ios (iOS-specific a11y)
- jc-qa (testing execution)

**Use Cases:**
- WCAG 2.1/2.2 compliance audits
- Component accessibility reviews
- Accessibility testing strategy
- Inclusive design reviews
- Mobile app a11y verification

---

### 2. `jc-android` — Android Development Specialist
**Alias:** Rodrigo

**Purpose:** Develop and maintain the multi-tenant lh-group-app-android platform.

**Specialization Areas:**
- Jetpack Compose (MVI architecture)
- Hilt dependency injection framework
- Gradle module architecture and build configuration
- SDUI (Server-Driven UI) renderer implementation
- Multi-tenant flavor configuration
- Paparazzi screenshot testing
- Android lifecycle management
- Performance optimization for mobile

**Primary Repository:** lh-group-app-android

**Technical Stack:**
- Language: Kotlin
- UI Framework: Jetpack Compose
- Dependency Injection: Hilt
- Build System: Gradle
- Architecture: MVI (Model-View-Intent)
- Testing: JUnit, Espresso, Paparazzi
- Rendering: SDUI engine integration

**Input Capabilities:**
- Kotlin/Compose code
- Gradle build files
- SDUI schema changes
- Design specifications
- Mobile UI mockups

**Output Deliverables:**
- Compose component implementations
- Gradle configuration updates
- Feature implementations
- Performance reports
- Test suites

**Coordination Partners:**
- jc-sdui-architect (schema and contracts)
- jc-qa (testing and QA)
- jc-devops (CI/CD for Android)
- jc-design-system (component library)

**Use Cases:**
- Feature development
- Multi-tenant flavor management
- Build system optimization
- Compose component creation
- SDUI renderer updates
- Performance tuning
- Dependency updates

---

### 3. `jc-design-system` — Design System Specialist
**Alias:** Luis

**Purpose:** Maintain DH-DesignSystem and component library standards.

**Specialization Areas:**
- Lit web components (DESY 2.0 / MAUI 1.0)
- Design token pipeline and management
- Multi-tenant theming system
- Storybook documentation and showcase
- WCAG 2.1/2.2 compliance in components
- Component API design
- Cross-renderer consistency
- TypeScript type safety for components

**Primary Repository:** DH-DesignSystem (@lhgdesy/maui-components)

**Technical Stack:**
- Language: TypeScript
- Component Framework: Lit (Web Components)
- Design Tokens: CSS custom properties
- Documentation: Storybook
- Build System: Yarn/npm
- Testing: Jest, Playwright
- Version Management: SemVer

**Input Capabilities:**
- Component specifications
- Design token requirements
- Design mockups/Figma files
- Theme requirements
- Accessibility requirements

**Output Deliverables:**
- Lit web component implementations
- Design token configurations
- Storybook stories and documentation
- Component API documentation
- TypeScript type definitions
- Accessibility compliance reports

**Coordination Partners:**
- jc-a11y (accessibility compliance)
- jc-qa (testing strategy)
- jc-devops (release automation)
- web-component-renderer-react (renderer integration)

**Use Cases:**
- Component creation/updates
- Design token system evolution
- Storybook documentation
- Multi-tenant theme implementation
- Accessibility improvements
- Component library versioning
- Renderer compatibility updates

---

### 4. `jc-devops` — DevOps & CI/CD Specialist
**Alias:** Phill

**Purpose:** Optimize and maintain CI/CD infrastructure across JowCodes.

**Specialization Areas:**
- Azure Pipelines configuration and optimization
- Build pipeline design and maintenance
- Pull request quality gates
- Deployment automation
- CI quality gate execution
- Pipeline performance tuning
- Artifact management
- Cross-repo build coordination

**Primary Platforms:** Azure Pipelines, GitHub/Azure DevOps

**Configuration Files:**
- `azure-pipelines.yml`
- Build scripts and Makefiles
- Deployment configurations
- Quality gate definitions
- Secret management

**Input Capabilities:**
- Pipeline requirements
- Build scripts
- Test reports
- Deployment targets
- Performance metrics

**Output Deliverables:**
- Pipeline configurations
- Build optimization reports
- Quality gate reports
- Deployment success/failure analysis
- Performance metrics and alerts
- Runbooks for common failures

**Coordination Partners:**
- jc-android (Android build optimization)
- jc-ios (iOS build optimization)
- jc-qa (test execution in pipeline)
- jc-release (release automation)

**Use Cases:**
- Pipeline creation/updates
- Build time optimization
- Quality gate enforcement
- Deployment automation
- Artifact versioning
- Failure diagnosis and fix
- Cross-platform build coordination

---

### 5. `jc-docs` — Documentation Specialist
**Alias:** Dani

**Purpose:** Maintain and sync technical documentation across JowCodes.

**Specialization Areas:**
- AGENTS.md authoring and updates
- README creation and maintenance
- ADR (Architecture Decision Record) documentation
- Reference Files section management
- Doc sync validation with codebase
- Documentation structure and organization
- Cross-repo documentation consistency
- Changelog and release notes

**Documentation Types:**
- Architecture Decision Records (ADR)
- API documentation
- Setup guides and onboarding
- Integration documentation
- Performance guides
- Testing strategies
- Configuration references

**Input Capabilities:**
- Code changes and new features
- Architecture decisions
- API specifications
- Integration requirements
- User feedback

**Output Deliverables:**
- Markdown documentation
- ADR files in standard format
- README files
- Reference files (code examples, configs)
- Documentation sync reports
- Changelog entries

**Coordination Partners:**
- All DH agents (documentation input)
- jc-pm (release documentation)
- jc-devops (deployment docs)
- jc-qa (testing documentation)

**Use Cases:**
- Architecture documentation
- Setup guide creation
- API documentation updates
- Reference file synchronization
- Doc validation across repos
- Changelog authoring
- Onboarding material creation

---

### 6. `jc-ios` — iOS Development Specialist
**Alias:** Donizete

**Purpose:** Develop and maintain the multi-tenant lh-group-app-ios platform.

**Specialization Areas:**
- Swift/SwiftUI development
- SDUI (Server-Driven UI) rendering on iOS
- Multi-tenant configuration and flavor management
- iOS-specific performance optimization
- XCTest unit and integration testing
- iOS lifecycle management
- Cocoapods/SPM dependency management
- Xcode build configuration

**Primary Repository:** lh-group-app-ios

**Technical Stack:**
- Language: Swift
- UI Framework: SwiftUI
- Build System: Xcode, CocoaPods/SPM
- Architecture: MVVM/VIPER
- Testing: XCTest, Quick/Nimble
- Rendering: SDUI engine integration

**Input Capabilities:**
- Swift/SwiftUI code
- Xcode build configuration
- SDUI schema changes
- Design specifications
- iOS mockups

**Output Deliverables:**
- SwiftUI view implementations
- iOS feature implementations
- Performance reports
- Test suites
- Build configuration updates

**Coordination Partners:**
- jc-sdui-architect (schema and contracts)
- jc-qa (testing and QA)
- jc-devops (CI/CD for iOS)
- jc-design-system (component library)

**Use Cases:**
- Feature development
- Multi-tenant configuration
- SwiftUI component creation
- SDUI renderer updates
- Performance tuning
- Dependency management
- iOS-specific bug fixes

---

### 7. `jc-mcp` — MCP & Jira Integration Specialist
**Alias:** Hirama

**Purpose:** Design and maintain MCP servers and Jira/TrackSpace integrations.

**Specialization Areas:**
- MCP (Model Context Protocol) server setup and deployment
- Jira API integration
- TrackSpace workflow automation
- MCP tool development and design
- Workflow automation via MCP servers
- Jira custom fields and configurations
- Issue tracking integration
- Automation rules and triggers

**Primary Platforms:** MCP servers, Jira Cloud, TrackSpace

**Technical Stack:**
- Protocols: Model Context Protocol (MCP)
- APIs: Jira REST API
- Languages: Python, TypeScript
- Transport: HTTP, stdio
- Authentication: OAuth 2.1, API keys

**Input Capabilities:**
- MCP server specifications
- Jira workflow requirements
- Automation requirements
- Integration specifications
- Custom tool requirements

**Output Deliverables:**
- MCP server implementations
- Jira configuration updates
- Automation scripts
- Integration documentation
- Custom tool implementations
- API integration examples

**Coordination Partners:**
- jc-pm (workflow requirements)
- jc-devops (deployment infrastructure)
- jc-docs (integration documentation)
- Development teams (tool integration)

**Use Cases:**
- MCP server development
- Jira automation setup
- Custom tool creation
- Workflow automation
- Issue tracking integration
- Notification automation
- Release process automation

---

### 8. `jc-pm` — Project Management Specialist
**Alias:** Cadu

**Purpose:** Manage backlog, prioritization, and Definition of Ready (DOR).

**Specialization Areas:**
- Task prioritization and triage
- Backlog grooming and refinement
- Scope control and boundary definition
- Dependency identification and tracking
- Risk assessment and mitigation
- Definition of Ready (DOR) validation
- Capacity planning
- Release planning and coordination

**Input Capabilities:**
- Feature requests
- Bug reports
- Stakeholder feedback
- Team capacity metrics
- Technical constraints

**Output Deliverables:**
- Prioritized backlog
- Scope documentation
- Risk assessments
- DOR checklists
- Capacity reports
- Release plans
- Dependency maps

**Coordination Partners:**
- jc-qa (testing readiness)
- jc-docs (documentation completeness)
- jc-devops (deployment readiness)
- jc-release (release coordination)
- Development teams (implementation feasibility)

**Use Cases:**
- Backlog prioritization
- Sprint planning
- Scope negotiation
- Risk identification
- DOR validation
- Release coordination
- Capacity planning

---

### 9. `jc-qa` — Testing & QA Specialist
**Alias:** Iuri

**Purpose:** Define and execute comprehensive testing strategies across all stacks.

**Specialization Areas:**
- Test strategy design (Unit, Integration, E2E)
- Test authoring and execution
- Coverage analysis and reporting
- Flakiness investigation and root cause analysis
- Test framework selection and optimization
- Regression test design
- Cross-platform testing coordination
- Quality metrics and KPIs

**Supported Stacks:**
- Lit/Web Components: Playwright, Jest
- Android: JUnit, Espresso, Paparazzi
- iOS: XCTest, Quick/Nimble
- React: Jest, Playwright, React Testing Library

**Input Capabilities:**
- Feature specifications
- Code changes
- Bug reports
- Performance metrics
- Test coverage reports

**Output Deliverables:**
- Test plans and strategies
- Test suite implementations
- Coverage reports
- Flakiness analysis and fixes
- Quality metrics
- Test automation recommendations
- Regression test suites

**Coordination Partners:**
- jc-devops (CI/CD integration)
- jc-android (Android testing)
- jc-ios (iOS testing)
- jc-design-system (component testing)
- Development teams (test implementation)

**Use Cases:**
- Test strategy development
- Test suite creation
- Coverage improvement
- Flakiness diagnosis
- Performance testing
- Regression prevention
- Quality gate definition

---

### 10. `jc-release` — Release Management Specialist
**Alias:** Jacinthe

**Purpose:** Manage versioning, changelogs, and release pipeline coordination.

**Specialization Areas:**
- SemVer (Semantic Versioning) decisions
- CHANGELOG authoring and maintenance
- Release pipeline coordination in Azure
- PR-to-production readiness assessment
- Version bump automation
- Release notes generation
- Hotfix coordination
- Rollback planning

**Input Capabilities:**
- Commit history
- Pull request descriptions
- Issue tracking data
- Feature specifications
- Breaking change documentation

**Output Deliverables:**
- Release plans
- CHANGELOG entries
- Version bump recommendations
- Release notes
- Readiness checklists
- Rollback procedures
- Release coordination timeline

**Coordination Partners:**
- jc-devops (deployment execution)
- jc-qa (testing verification)
- jc-docs (release documentation)
- jc-pm (release planning)
- Development teams (commit information)

**Use Cases:**
- Release version decisions
- CHANGELOG management
- Release readiness verification
- Hotfix coordination
- Version bump execution
- Release announcement creation
- Rollback procedure documentation

---

### 11. `jc-sdui-architect` — SDUI Cross-Platform Architect
**Alias:** Tupan

**Purpose:** Design and coordinate Server-Driven UI (SDUI) architecture across platforms.

**Specialization Areas:**
- kotlin-sdui-engine architecture and evolution
- iOS SDUI renderer implementation
- Android SDUI renderer implementation
- Web SDUI renderer (React) implementation
- OpenAPI contract versioning and management
- Schema migration strategy and coordination
- Cross-renderer rollout strategy
- Backward compatibility enforcement
- Contract versioning (major, minor, patch)

**Platforms:**
- **Engine:** kotlin-sdui-engine (server)
- **Renderers:** iOS (Swift), Android (Kotlin), Web (React)
- **Schema:** OpenAPI format with versioning

**Input Capabilities:**
- Schema change proposals
- Renderer implementations
- Breaking change assessments
- Performance requirements
- Feature specifications

**Output Deliverables:**
- Schema change documentation
- Contract versioning recommendations
- Migration strategies
- Rollout coordination plans
- Renderer compatibility reports
- Performance analysis
- Architecture decision records (ADR)

**Coordination Partners:**
- jc-android (Android renderer updates)
- jc-ios (iOS renderer updates)
- Web team (React renderer updates)
- jc-devops (deployment coordination)
- jc-release (version coordination)

**Use Cases:**
- Schema design and evolution
- Cross-platform renderer coordination
- Breaking change management
- Contract versioning decisions
- Rollout strategy planning
- Backward compatibility verification
- Performance optimization across renderers

---

### 12. `jc-security` — Security Specialist
**Alias:** Mark

**Purpose:** Audit and enforce security standards across JowCodes.

**Specialization Areas:**
- Threat modeling (STRIDE methodology)
- OWASP Top 10 vulnerability identification
- Secrets management and credential handling
- Dependency auditing (vulnerability scanning)
- Input validation and sanitization
- Secure code review
- Authentication and authorization patterns
- Data encryption (at rest and in transit)
- Supply chain security
- Compliance mapping (NIST, ISO, etc.)

**Input Capabilities:**
- Source code
- Architecture diagrams
- API specifications
- Dependency lists
- Configuration files
- Security requirements
- Threat models

**Output Deliverables:**
- Security audit reports
- Vulnerability findings (CVSS scored)
- Remediation recommendations
- Threat models
- Security architecture reviews
- Best practices guidance
- Compliance mapping
- Security testing recommendations

**Coordination Partners:**
- All DH development teams (code review)
- jc-devops (infrastructure security)
- jc-design-system (component security)
- jc-qa (security testing)

**Use Cases:**
- Pre-release security audits
- Vulnerability assessment
- Secrets management review
- Dependency vulnerability scanning
- Authorization logic review
- Data encryption verification
- Supply chain security audit
- Compliance verification

---

## Development Tools Agents (1)

### `dev-tools:skill-creator-agent` — Skill Creation Orchestrator
**Purpose:** Orchestrate full skill creation and improvement lifecycle.

**Specialization Areas:**
- Skill specification and design
- Quality auditing of skill implementations
- Structural validation of skill code
- Evaluation and testing (evals)
- Performance benchmarking
- Description optimization for LLM triggering
- Skill iteration and refinement
- Release readiness assessment

**Lifecycle Phases:**
1. **Draft:** Initial skill concept and specification
2. **Quality Audit:** Implementation review
3. **Structural Validation:** Code structure verification
4. **Evals:** Performance and correctness testing
5. **Benchmark:** Variance analysis and metrics
6. **Review:** Acceptance criteria verification
7. **Iterate:** Refinement based on feedback
8. **Description Optimization:** Enhance triggering accuracy

**Input Capabilities:**
- Skill concept/requirements
- Skill implementation code
- Eval criteria and test cases
- Performance benchmarks
- Feedback for iteration

**Output Deliverables:**
- Complete skill implementation
- Eval results and reports
- Performance benchmarks
- Quality audit reports
- Description optimization recommendations
- Release approval/rejection

**Integration Points:**
- Claude Code platform
- Skill validation tools
- Test execution framework
- Performance measurement tools

**Use Cases:**
- New skill creation from scratch
- Existing skill improvements
- Skill performance optimization
- Skill reliability enhancement
- Triggering accuracy improvement
- Skill release and deployment

---

## Caveman Specialist Agents (3)

These agents are specialized for compressed, efficient operation with minimal context overhead and maximum token efficiency.

---

### `caveman:cavecrew-builder` — Surgical Code Editor
**Purpose:** Execute precise, minimal-scope code edits with caveman-style output.

**Constraints:**
- **Hard limit:** 1-2 files per invocation
- **Scope:** Typos, function rewrites, mechanical renames, comment removal, format tweaks
- **Style:** Caveman-compressed output (60-70% token reduction)
- **Output:** Caveman diff receipt

**Use Cases:**
- Single-file typo fixes
- Function rewrites (1 function max)
- Variable name refactoring
- Comment cleanup
- Format-preserving tweaks

**NOT Recommended For:**
- Multi-file refactors (3+ files)
- New feature development
- Major architecture changes
- Cross-file dependencies

**Integration Pattern:**
```
Inline instruction → cavecrew-builder → Caveman diff receipt
```

---

### `caveman:cavecrew-investigator` — Code Locator
**Purpose:** Locate code symbols, call graphs, and usage maps with compressed output.

**Capabilities:**
- "Where is X defined?"
- "What calls Y?"
- "List all uses of Z"
- "Map this directory structure"
- Dependency graph visualization

**Output Format:**
- File:line table (compressed)
- Symbol definitions
- Call graphs
- Usage maps
- Directory structure

**Token Efficiency:**
- 60% context reduction vs. vanilla Explore
- Compressed caveman output
- Minimal explanation

**Use Cases:**
- Symbol location
- Call chain analysis
- Dependency mapping
- Architecture understanding
- Impact analysis

---

### `caveman:cavecrew-reviewer` — Diff Reviewer
**Purpose:** Review diffs, branches, or files with one-line severity-tagged findings.

**Review Scope:**
- Staged diffs
- Unstaged changes
- Branch-to-branch diffs
- Entire files

**Output Format:**
```
path:line: <emoji> <severity>: <problem>. <fix>.
```

**Characteristics:**
- One finding per line
- Severity tagging (Critical, High, Medium, Low)
- Problem statement
- Fix suggestion
- No praise or scope creep
- No formatting nits (unless semantic impact)

**Findings Include:**
- High-confidence bugs
- Security vulnerabilities
- Logic errors
- Performance issues
- Type safety problems

**Excluded:**
- Style issues (unless meaningful)
- Trivial formatting
- Opinion-based feedback

**Integration Pattern:**
```
User: "Review this PR"
cavecrew-reviewer → One-line severity-tagged findings
```

---

## Research & Documentation Agents (1)

### `context7:docs-researcher` — Documentation Researcher
**Purpose:** Lightweight documentation fetching without main context clutter.

**Specialization:**
- Library documentation retrieval
- Framework reference lookup
- SDK documentation
- API documentation
- Installation guides
- Quick-start examples

**Design Principle:**
- Isolated documentation retrieval
- No main conversation bloat
- Efficient, focused output
- Minimal token overhead

**Input Requirements:**
- Library/framework name
- Optional: specific version
- Optional: topic scope

**Output Specification:**
- Clean documentation extract
- Markdown formatted
- Examples and code snippets
- Quick-start guide
- API reference sections

**Integration Points:**
- Context7 MCP server
- Web documentation sources
- Official APIs

**Use Cases:**
- Framework setup guidance
- Library API reference
- Code generation with libraries
- Integration documentation
- Version-specific features

---

## Agent Coordination Patterns

### Cross-Agent Workflows

#### Feature Development Workflow
```
jc-pm (Planning)
  → jc-android/ios/design-system (Implementation)
  → jc-qa (Testing)
  → jc-a11y (Accessibility review)
  → jc-security (Security review)
  → jc-release (Versioning)
  → jc-devops (Deployment)
```

#### SDUI Schema Change Workflow
```
jc-sdui-architect (Design)
  → jc-android (Android renderer)
  → jc-ios (iOS renderer)
  → Web team (React renderer)
  → jc-release (Version coordination)
  → jc-devops (Deployment in sequence)
  → Monitoring (24h error rate tracking)
```

#### Documentation Sync Workflow
```
jc-docs (Audit)
  → All agents (Input collection)
  → jc-docs (Documentation update)
  → jc-qa (Verification testing)
  → jc-devops (CI/CD integration)
```

#### Release Workflow
```
jc-release (Planning)
  → jc-qa (Testing verification)
  → jc-docs (CHANGELOG generation)
  → jc-devops (Deployment execution)
  → jc-security (Post-release audit)
```

---

## Decision Trees

### "Which Agent Should I Use?"

**Platform Domain?**

- 🎨 **Design & Components**
  - → `jc-design-system` (component work)
  - → `jc-a11y` (accessibility review)

- 📱 **Mobile Development**
  - → `jc-android` (Android features)
  - → `jc-ios` (iOS features)

- 🛠️ **Infrastructure & Automation**
  - → `jc-devops` (CI/CD, pipelines)
  - → `jc-mcp` (integrations, automation)

- 📊 **Project & Process**
  - → `jc-pm` (planning, prioritization)
  - → `jc-release` (versioning, release)

- ✅ **Quality & Testing**
  - → `jc-qa` (test strategy, execution)
  - → `jc-security` (security audit)

- 📚 **Documentation & Knowledge**
  - → `jc-docs` (technical documentation)
  - → `context7:docs-researcher` (library docs)

- 🏗️ **Architecture**
  - → `jc-sdui-architect` (SDUI/cross-platform)

- 📝 **Code Editing (Compressed)**
  - → `caveman:cavecrew-builder` (1-2 files)
  - → `caveman:cavecrew-investigator` (code location)
  - → `caveman:cavecrew-reviewer` (diff review)

- 🔧 **Skill Development**
  - → `dev-tools:skill-creator-agent` (skill lifecycle)

---

## Agent Characteristics

| Agent | Type | Focus | Compression | Coordination |
|-------|------|-------|-------------|--------------|
| jc-a11y | Specialist | Accessibility | Standard | High |
| jc-android | Specialist | Android dev | Standard | High |
| jc-design-system | Specialist | Components | Standard | High |
| jc-devops | Specialist | CI/CD | Standard | High |
| jc-docs | Specialist | Documentation | Standard | Medium |
| jc-ios | Specialist | iOS dev | Standard | High |
| jc-mcp | Specialist | Integrations | Standard | Medium |
| jc-pm | Specialist | Project mgmt | Standard | High |
| jc-qa | Specialist | Testing | Standard | High |
| jc-release | Specialist | Releases | Standard | High |
| jc-sdui-architect | Specialist | Architecture | Standard | Very High |
| jc-security | Specialist | Security | Standard | High |
| dev-tools:skill-creator | Orchestrator | Skill lifecycle | Standard | Medium |
| cavecrew-builder | Specialist | Code editing | Compressed | Low |
| cavecrew-investigator | Specialist | Code search | Compressed | Low |
| cavecrew-reviewer | Specialist | Code review | Compressed | Low |
| context7:docs-researcher | Specialist | Documentation | Compressed | Low |

---

## Performance & Resource Characteristics

| Agent | Typical Duration | Context Impact | Token Overhead | Parallelizable |
|-------|-----------------|-----------------|-----------------|-----------------|
| jc-a11y | 10-20min | High | Medium | Yes |
| jc-android | 15-45min | Very High | High | Yes |
| jc-design-system | 10-30min | High | Medium | Yes |
| jc-devops | 5-15min | Medium | Medium | Yes |
| jc-docs | 10-30min | High | Medium | Yes |
| jc-ios | 15-45min | Very High | High | Yes |
| jc-mcp | 10-20min | Medium | Medium | Yes |
| jc-pm | 5-15min | Low | Low | Yes |
| jc-qa | 15-60min | Very High | High | Yes |
| jc-release | 5-10min | Low | Low | Yes |
| jc-sdui-architect | 20-60min | Very High | Very High | Limited |
| jc-security | 20-60min | Very High | High | Limited |
| dev-tools:skill-creator | 30-120min | Very High | Very High | No |
| cavecrew-builder | <5min | Minimal | Minimal | Yes |
| cavecrew-investigator | 2-5min | Minimal | Minimal | Yes |
| cavecrew-reviewer | 2-10min | Minimal | Minimal | Yes |
| context7:docs-researcher | <5min | Minimal | Low | Yes |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-07-28 | Initial comprehensive agents reference |

---

## Contribution & Updates

To update this reference:
1. Verify agent capabilities against implementation
2. Document changes in version history
3. Update coordination patterns and workflows
4. Validate decision trees and use cases
5. Submit review via standard PR process

