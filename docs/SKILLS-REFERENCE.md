# Skills Reference Guide

**Version:** 1.0  
**Last Updated:** 2026-07-28  
**Scope:** AI-Agnostic, Stack-Agnostic Skill Specifications

This document provides a complete reference for all 19 available skills in the Copilot ecosystem. Each skill is documented with its purpose, capabilities, inputs, outputs, and integration points, independent of any specific AI model or development stack.

---

## Quick Reference

| Category | Skills | Count |
|----------|--------|-------|
| Git & Automation | commit, create-pr | 2 |
| Research & Analysis | deep-explore, spawn-agent | 2 |
| Development & Testing | quick-epct, test | 2 |
| Documentation | readme, docs, context7-mcp | 3 |
| Code Quality | prod-ready, yaml-validator | 2 |
| AI Engineering | prompt, claude-code-expert, skill-creator | 3 |
| Efficiency & Compression | caveman, cavecrew, caveman-compress | 3 |
| Knowledge Transfer | handoff | 1 |
| Platform Configuration | customize-cloud-agent | 1 |

---

## Core Skills Specifications

### 1. Git & Version Control

#### `commit` — Conventional Commits
**Purpose:** Automate git commit creation following Conventional Commits specification.

**Type:** Automation / Git Integration  
**Invocation Pattern:** User requests commit or `/commit` command  
**Input Requirements:**
- Staged files (implicit)
- Commit scope (required)
- Commit description (required)
- Optional: body content, co-author info

**Output Specification:**
- Formatted commit message: `type(scope): description [TICKET|NO-ISSUE]`
- Commit SHA (after execution)
- Status confirmation

**Constraints:**
- Never uses `git add --all`
- Never adds co-author attributions unless explicitly requested
- Requires files to be pre-staged
- Header ≤ 100 characters
- Body lines ≤ 300 characters

**Integration Points:**
- Git CLI
- Project repository context
- Issue tracking systems (Jira, GitHub Issues)

**Use Cases:**
- Standardized commit workflows
- Multi-file coordinated changes
- Ticket-linked commits
- Team compliance enforcement

---

#### `create-pr` — Pull Request Creator
**Purpose:** Create pull requests with automatic template discovery and context extraction.

**Type:** Automation / Code Review  
**Invocation Pattern:** User requests `create-pr` or `/create-pr`  
**Input Requirements:**
- Current branch (implicit from git context)
- Optional: PR title (auto-generated from diff)
- Optional: PR description (auto-generated from commits)
- Optional: work item link (Azure DevOps)

**Output Specification:**
- PR title and description (Markdown formatted)
- Link to created PR
- Status confirmation
- Template compliance report

**Supported Platforms:**
- GitHub (`gh` CLI)
- Azure DevOps (`az` CLI)

**Capabilities:**
- Auto-detects PR templates in repository
- Extracts context from branch diff
- Extracts context from commit history
- Links Azure DevOps work items
- Generates title and description intelligently

**Constraints:**
- Requires remote tracking branch
- Requires repository context

**Use Cases:**
- Standardized PR creation
- Multi-platform support (GitHub + Azure DevOps)
- Automated template compliance
- Ticket linkage automation

---

### 2. Research & Analysis

#### `deep-explore` — Deep Exploration
**Purpose:** Decompose research goals into parallel exploration tasks with findings synthesis.

**Type:** Research / Multi-Agent Orchestration  
**Invocation Pattern:** Triggered on research requests, "explore this thoroughly", "understand X"  
**Input Requirements:**
- Research objective (clear statement)
- Source materials (codebases, documents, APIs)
- Optional: exploration scope constraints

**Output Specification:**
- Structured findings report (Markdown)
- Multiple parallel investigation results
- Synthesized conclusions
- Evidence citations

**Decomposition Strategy:**
- Breaks goals into 3-7 focused exploration tasks
- Dispatches tasks as parallel agents
- Each agent writes structured findings to file
- Final synthesis combines all findings

**Integration Points:**
- Sub-agent coordination (spawn-agent)
- File system (results storage)
- Search tools (grep, glob, web fetch)

**Use Cases:**
- Deep codebase understanding
- API/framework research
- Architecture exploration
- Multi-aspect problem analysis
- Document discovery and synthesis

**NOT Recommended For:**
- Simple lookups (use grep/view instead)
- Single-file exploration
- Time-sensitive changes

---

#### `spawn-agent` — Agent Spawner
**Purpose:** Create isolated sub-agents in fresh context to prevent main conversation bloat.

**Type:** Orchestration / Context Management  
**Invocation Pattern:** User requests "spawn agent", "fresh context", "delegate this"  
**Input Requirements:**
- Task description (complete context required)
- Optional: agent type specification
- Optional: output format

**Output Specification:**
- Sub-agent execution results
- Isolated findings (no context pollution)
- Clean return to parent context

**Design Principle:**
- Each sub-agent is stateless
- Complete context must be provided in prompt
- No implicit knowledge sharing
- Results returned in single message

**Use Cases:**
- Large file processing
- Heavy tool usage
- Long exploration chains
- Keeping main conversation lean

**NOT Recommended For:**
- Simple searches
- Single grep/view operations
- Tasks completable in ≤5 direct calls

---

### 3. Development Workflow

#### `quick-epct` — Quick Development Workflow
**Purpose:** Execute lightweight 4-phase development cycle for small-scoped tasks.

**Type:** Development Workflow  
**Invocation Pattern:** User requests implementation, fix, or feature update  
**Input Requirements:**
- Clear task description
- Scope constraints (file count, complexity)
- Optional: testing requirements

**Output Specification:**
- Implementation code
- Test coverage report
- Quality gate status

**Phase Sequence:**
1. **Explore:** Understand codebase context
2. **Plan:** Sketch implementation approach
3. **Code:** Write and test changes
4. **Test:** Verify functionality

**Constraints:**
- Best for ≤5 file changes
- Clear, well-scoped tasks only
- Small to medium complexity

**Integration Points:**
- Source code repository
- Build system
- Test runner

**Use Cases:**
- Bug fixes
- Small feature additions
- Configuration updates
- UI tweaks
- Targeted refactoring

**NOT Recommended For:**
- Multi-system refactors
- Large architectural changes
- Deep research-heavy tasks

---

#### `test` — Test Executor
**Purpose:** Auto-detect and run project test suite with strict reporting.

**Type:** Quality Assurance / Testing  
**Invocation Pattern:** User requests "run tests", "check tests", "test it"  
**Input Requirements:**
- Project context (implicit)
- Optional: test filter/selection

**Output Specification:**
- Test results summary
- Pass/fail counts
- Error messages (on failure)
- Full output (on failure only)
- Coverage metrics (optional)

**Capabilities:**
- Auto-detects test framework (Jest, pytest, go test, etc.)
- Runs unit, integration, e2e tests
- Supports all major languages
- Prevents sugarcoating results
- Tracks regression

**Reporting Protocol:**
- SUCCESS: Brief summary only
- FAILURE: Full stack traces and logs
- FLAKY: Highlighted test instability

**Use Cases:**
- Pre-commit verification
- Regression testing
- CI/CD integration
- Quality gate enforcement

---

### 4. Documentation

#### `readme` — README Generator
**Purpose:** Generate concise, engineer-focused project documentation.

**Type:** Documentation / Code Generation  
**Invocation Pattern:** User requests "create README" or "update README"  
**Input Requirements:**
- Project context (implicit from codebase)
- Optional: custom sections

**Output Specification:**
- Markdown-formatted README
- Command-first structure
- Quick-start guide
- Feature overview
- Installation instructions

**Documentation Pattern:**
1. Explore codebase
2. Extract key information
3. Generate scannable structure
4. Prioritize commands and examples

**Use Cases:**
- Project initialization
- Documentation updates
- Repository onboarding
- README modernization

---

#### `docs` — Docs Lookup
**Purpose:** Fetch documentation for any library or framework.

**Type:** Documentation / Reference  
**Invocation Pattern:** User asks about library documentation  
**Input Requirements:**
- Library name (required)
- Optional: specific topic

**Output Specification:**
- Library documentation (Markdown or raw HTML)
- Version information
- Quick-start examples
- API reference sections

**Integration Points:**
- Context7 MCP server
- Web documentation sources
- Official API references

**Use Cases:**
- Library research
- API documentation lookup
- Framework feature discovery
- Version-specific guidance

---

#### `context7-mcp` — Library Documentation Fetcher
**Purpose:** Lightweight agent for fetching library/framework documentation without cluttering main context.

**Type:** Documentation / Specialized Research  
**Invocation Pattern:** Auto-triggered for library/framework questions  
**Input Requirements:**
- Library identifier (name or URL)
- Optional: specific version
- Optional: section scope

**Output Specification:**
- Clean documentation extract
- Markdown-formatted
- No context bloat

**Design Principle:**
- Keeps main conversation lean
- Isolated documentation retrieval
- Minimal token usage

**Use Cases:**
- Setup questions
- Code generation with libraries
- Framework examples
- API reference lookups

---

### 5. Code Quality & Validation

#### `prod-ready` — Production Readiness Audit
**Purpose:** Comprehensive audit against enterprise security, reliability, and quality standards.

**Type:** Quality Assurance / Audit  
**Invocation Pattern:** User requests "review before release", "production ready check", "pre-deploy audit"  
**Input Requirements:**
- Codebase context (implicit)
- Optional: audit scope
- Optional: compliance requirements

**Output Specification:**
- Findings report (prioritized)
- Actionable tickets
- Severity classification
- Remediation guidance

**Audit Dimensions:**
- Security vulnerabilities
- Reliability patterns
- Code quality metrics
- Testing coverage
- Observability/monitoring
- Performance characteristics

**Constraints:**
- Read-only audit
- Non-invasive analysis
- Enterprise standard comparison

**Integration Points:**
- Codebase analyzer
- Security scanning
- Test framework assessment
- Dependency auditor

**Use Cases:**
- Pre-release audits
- Production deployment checks
- Code quality baseline
- Risk assessment
- Compliance verification

---

#### `yaml-validator` — YAML Frontmatter Validator
**Purpose:** Validate YAML frontmatter in skill and agent markdown files.

**Type:** Validation / Configuration  
**Invocation Pattern:** Auto-triggered after skill/agent file creation  
**Input Requirements:**
- Markdown file with YAML frontmatter
- Optional: validation schema

**Output Specification:**
- Parse success/failure report
- Error locations and messages
- Remediation suggestions

**Validation Coverage:**
- YAML syntax compliance
- Schema adherence
- Unquoted colon detection
- Field type validation

**Use Cases:**
- Skill definition validation
- Agent configuration validation
- CI/CD quality gates
- Developer feedback

---

### 6. AI Engineering

#### `prompt` — Prompt Engineering
**Purpose:** Create or improve prompts using Claude 4.x best practices.

**Type:** AI Engineering / Prompt Optimization  
**Invocation Pattern:** User requests prompt creation or improvement  
**Input Requirements:**
- Prompt intent (required)
- Current prompt (optional, for refinement)
- Target domain/context
- Optional: success criteria

**Output Specification:**
- Improved prompt (Markdown)
- Application examples
- Best practices applied

**Techniques Applied:**
- Explicit instructions
- Sequential step organization
- Chain-of-thought patterns
- XML tag structuring
- Extended thinking tips
- Example-driven design

**Use Cases:**
- Prompt refinement
- LLM interaction optimization
- System prompt design
- Few-shot learning setup

---

#### `claude-code-expert` — Claude Code Configuration
**Purpose:** Reference and best practices for Claude Code platform features.

**Type:** Platform Configuration / Knowledge Reference  
**Input Requirements:**
- Specific Claude Code feature question
- Configuration context

**Output Specification:**
- Best practices guidance
- Configuration examples
- Integration patterns

**Coverage Areas:**
- Skill creation and structuring
- Hook event automation
- Settings (permissions, restrictions)
- Memory hierarchy (CLAUDE.md)
- Sub-agent spawning
- Plugin packaging

**Use Cases:**
- Platform feature questions
- Configuration guidance
- Best practices reference
- Architecture decisions

---

#### `skill-creator` — Skill Lifecycle Manager
**Purpose:** Full skill lifecycle: creation, modification, improvement, evals, benchmarking.

**Type:** Skill Management / Quality Engineering  
**Invocation Pattern:** User requests skill creation/improvement  
**Input Requirements:**
- Skill specification
- Target improvement area
- Optional: eval criteria

**Output Specification:**
- Complete skill implementation
- Eval results
- Performance benchmarks
- Quality audit report

**Lifecycle Phases:**
1. **Draft:** Initial skill definition
2. **Audit:** Quality review
3. **Validation:** Structure verification
4. **Evals:** Performance testing
5. **Benchmark:** Variance analysis
6. **Review:** Acceptance criteria
7. **Iterate:** Refinement loop
8. **Optimize:** Description tuning

**Integration Points:**
- Skill creation tools
- Claude Code platform
- Test execution
- Performance measurement

**Use Cases:**
- New skill creation
- Existing skill enhancement
- Performance optimization
- Skill reliability improvement

---

### 7. Efficiency & Token Optimization

#### `caveman` — Caveman Communication Mode
**Purpose:** Ultra-compressed technical communication cutting output 65% token usage.

**Type:** Efficiency / Communication Style  
**Invocation Pattern:** User requests "caveman mode" or `/caveman`  
**Input Requirements:**
- Task context (required)
- Intensity level specification (optional)

**Output Specification:**
- Compressed technical output (65% token reduction)
- Caveman speech style
- Full technical accuracy maintained

**Intensity Levels:**
- `lite`: 40% reduction
- `full`: 65% reduction (default)
- `ultra`: 75% reduction
- `wenyan-lite`: Chinese philosophical compression
- `wenyan-full`: Chinese style (65% reduction)
- `wenyan-ultra`: Chinese style (75% reduction)

**Preservation Guarantees:**
- Full technical accuracy
- Code fidelity
- URL/link preservation
- Structure integrity

**Use Cases:**
- Context-limited sessions
- Long-running workflows
- Token budget management
- Verbose output scenarios

---

#### `cavecrew` — Cavecrew Delegation Guide
**Purpose:** Decide when to delegate to caveman-style specialized subagents.

**Type:** Orchestration / Context Efficiency  
**Invocation Pattern:** User requests efficient delegation  
**Input Requirements:**
- Task scope and type
- Context constraints

**Output Specification:**
- Delegation recommendation
- Subagent type suggestion
- Expected compression benefit

**Available Subagents:**
- `cavecrew-investigator`: Code location, compressed output
- `cavecrew-builder`: 1-2 file edits, surgical changes
- `cavecrew-reviewer`: Diff/branch/file review, severity-tagged

**Compression Benefit:**
- Tool result injection: ~60% token reduction
- Main context sustainability
- Longer session duration

**Use Cases:**
- Large code searches
- Surgical edits
- Diff reviews
- Context preservation

---

#### `caveman-compress` — Memory Compressor
**Purpose:** Compress natural language memory files into caveman format.

**Type:** Efficiency / Knowledge Management  
**Invocation Pattern:** User requests `/caveman-compress FILEPATH`  
**Input Requirements:**
- Memory file path (CLAUDE.md, todos, preferences)
- Optional: compression intensity

**Output Specification:**
- Compressed memory file (caveman format)
- Human-readable backup (.original.md)
- Compression report

**Preservation Guarantees:**
- Technical substance intact
- Code examples preserved
- URLs preserved
- Structure maintained

**Use Cases:**
- Session memory optimization
- Token budget recovery
- Long-term memory files
- Knowledge base compression

---

### 8. Knowledge Transfer

#### `handoff` — Session Handoff
**Purpose:** Create structured handoff for zero-context-loss session transitions.

**Type:** Knowledge Transfer / Documentation  
**Invocation Pattern:** User requests handoff creation or `wrap up`  
**Input Requirements:**
- Session task description
- Progress state
- Decision history
- Optional: code artifacts

**Output Specification:**
- Structured handoff document
- HANDOFF.md file
- Task state capture
- Decision log
- Context preservation

**Document Sections:**
- Task objective
- Completed work
- Current blockers
- Decisions made
- Next immediate actions
- Code artifacts
- Assumptions and risks

**Use Cases:**
- Multi-session continuation
- Team handoffs
- Session wrapping
- Context preservation
- Progress documentation

---

### 9. Platform Configuration

#### `customize-cloud-agent` — Cloud Agent Customizer
**Purpose:** Customize Copilot cloud agent environment and dependencies.

**Type:** Platform Configuration / DevOps  
**Invocation Pattern:** User mentions `copilot-setup-steps.yml` or environment configuration  
**Input Requirements:**
- Configuration area (setup steps, runners, settings)
- Customization requirements
- Tool/dependency list

**Output Specification:**
- Updated configuration file
- Deployment validation
- Integration verification

**Configuration Areas:**
- `copilot-setup-steps.yml`: Pre-installation
- Runners: Execution environment
- Settings: Permissions and restrictions
- Tool preinstallation
- Dependency management

**Use Cases:**
- Cloud agent environment setup
- Tool preinstallation
- Runner configuration
- Dependency management
- CI/CD integration

---

## Cross-Skill Integration Patterns

### Workflow Combinations

#### Code Implementation Workflow
```
quick-epct (Explore/Plan) 
  → coding (Phase)
  → test (Execution)
  → commit (Finalization)
  → create-pr (Release)
```

#### Research & Documentation
```
deep-explore (Investigation)
  → readme (Documentation)
  → docs-lookup (Reference)
  → handoff (Preservation)
```

#### Quality & Release
```
prod-ready (Audit)
  → test (Verification)
  → create-pr (Process)
  → skill-creator (Optimization)
```

---

## Integration Guidelines

### For AI Model Implementations
- Each skill operates independently
- Skills declare input/output contracts
- Skills are stateless within invocation
- Context is passed explicitly

### For Development Stack Integration
- Skills are framework-agnostic
- CLI tools (git, etc.) are primary interfaces
- File system is shared context
- Environment variables for configuration

### For Orchestration Systems
- Use `spawn-agent` for isolation
- Use `cavecrew` for compression
- Chain skills via output → input
- Track execution state via logs

---

## Skill Selection Decision Tree

**Task Type?**

- 📝 **Writing/Documentation**
  - → `readme` (if project docs)
  - → `prompt` (if prompt optimization)
  - → `docs` (if reference needed)

- 🔍 **Research/Analysis**
  - → `deep-explore` (if multi-source)
  - → `spawn-agent` (if isolation needed)
  - → `context7-mcp` (if library docs)

- 💻 **Development/Coding**
  - → `quick-epct` (if ≤5 files)
  - → `test` (if testing needed)
  - → `skill-creator` (if skill work)

- ✅ **Quality/Release**
  - → `prod-ready` (if audit needed)
  - → `yaml-validator` (if config validation)
  - → `caveman-compress` (if token savings)

- 🚀 **Git/Automation**
  - → `commit` (if commit needed)
  - → `create-pr` (if PR needed)
  - → `customize-cloud-agent` (if environment)

- 📦 **Efficiency/Context**
  - → `caveman` (if compression needed)
  - → `cavecrew` (if delegation needed)
  - → `handoff` (if preservation needed)

---

## Performance Characteristics

| Skill | Complexity | Time Est. | Context Impact | Token Overhead |
|-------|-----------|-----------|-----------------|-----------------|
| commit | Low | <1min | Minimal | Low |
| create-pr | Medium | 2-3min | Low | Medium |
| deep-explore | High | 5-15min | High | High |
| spawn-agent | Medium | 3-10min | Isolated | Medium |
| quick-epct | High | 10-30min | High | High |
| test | Medium | 2-5min | Medium | Medium |
| readme | Medium | 3-10min | Medium | Medium |
| docs | Low | <1min | Low | Low |
| context7-mcp | Low | 1-2min | Low | Low |
| prod-ready | High | 10-20min | High | High |
| yaml-validator | Low | <1min | Minimal | Low |
| prompt | Medium | 5-10min | Medium | Medium |
| claude-code-expert | Low | 1-5min | Low | Low |
| skill-creator | High | 20-60min | Very High | Very High |
| caveman | Low | <1min | Minimal | -65% |
| cavecrew | Low | <1min | Minimal | Low |
| caveman-compress | Low | 1-2min | Minimal | -50% |
| customize-cloud-agent | Medium | 2-5min | Low | Medium |
| handoff | Medium | 5-10min | High | Medium |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-07-28 | Initial comprehensive skills reference |

---

## Contribution & Updates

To update this reference:
1. Verify skill capabilities against implementation
2. Document changes in version history
3. Update decision trees and workflow diagrams
4. Validate example code and integrations
5. Submit review via standard PR process

