# 📚 Skill Catalog & Taxonomy

This is the master index of all professional expertise modules available to the JOW-AI ecosystem. Agents use this index to identify which specialist persona to invoke for a given task.

## 🛠️ Taxonomy

### 💻 Software Engineering (Core)
*High-density expertise for the software development lifecycle.*

- **`engineering-principles`**: SOLID, object-oriented design, Clean Code,
  KISS, DRY, YAGNI, and maintainable boundaries.
- **`closed-loop`**: Acceptance criteria, fresh verification, independent
  review, bounded correction, and honest completion states.
- **`coding`**: Implementation of algorithms, data structures, and language-specific patterns.
- **`architecture`**: Structural design, design patterns, and system decomposition.
- **`refactoring`**: Code cleanup, complexity reduction, and pattern migration.
- **`testing`**: TDD, unit, integration, and E2E testing strategies.
- **`typescript`**: Advanced type-level programming and type safety.

### 🛡️ Quality, Security & Reliability
*Specialized oversight to ensure production-grade excellence.*

- **`security-audit`**: Vulnerability detection, OWASP compliance, and secure coding.
- **`performance`**: Optimization of runtime, memory, and network efficiency.
- **`qa-engineer`**: Systematic verification and edge-case identification.
- **`reliability`**: Error handling, resilience patterns, and stability.

### 🎨 Frontend & User Experience
*Expertise in building intuitive, accessible, and high-performance interfaces.*

- **`ui-ux`**: User flow, interaction design, and usability patterns.
- **`accessibility`**: WCAG compliance, ARIA, and inclusive design.
- **`design-system`**: Token management, component architecture, and visual consistency.
- **`styling`**: CSS, Tailwind, and advanced animation/motion.

### 🚀 DevOps & Infrastructure
*Automating the path from code to production.*

- **`devops`**: CI/CD pipelines, containerization, and infrastructure as code.
- **`deployment`**: Vercel, Cloudflare, and cloud-native deployment strategies.
- **`mcp-integration`**: Designing and implementing Model Context Protocol tools.

### 🧠 Cognitive & Analytical
*Higher-order reasoning and knowledge management.*

- **`analysis`**: Deep-dive debugging, root cause analysis, and log investigation.
- **`documentation`**: Technical writing, API docs, and knowledge synthesis.
- **`knowledge-management`**: Managing durable context, episodic memory, and
  semantic links through a configured adapter.
- **`memory`**: Portable durable context, search-before-add, handoff, and
  secret-free persistence.
- **`decision-gate`**: Narrow compliance decisions with criteria, confidence,
  evidence, and human confirmation.
- **`caveman-workflow`**: Evidence-preserving internal compression after
  decision gates and verification.
- **`grilling`**: Adversarial questioning of plans, assumptions, risks, and
  architecture before execution.
- **`quality-gate`**: Acceptance criteria, fresh verification evidence, and
  independent review before completion.
- **`feature-validation`**: Observable acceptance criteria, boundary cases,
  current evidence, and explicit validation outcomes.
- **`subagent-briefs`**: Complete, bounded briefs for delegated work.
- **`session-lifecycle`**: Safe pause, resume, handoff, and checkpoint state.
- **`verification-ledger`**: Verification evidence bound to current commits and
  other immutable fingerprints.
- **`adversarial-review`**: Multi-lens review of correctness, architecture,
  security, testing, and evidence quality.
- **`skill-lifecycle`**: Create, validate, test, and maintain reusable skills.
- **`capability-mapping`**: Map portable capabilities to host-specific support.
- **`codebase-context`**: Safely package and inspect large repositories.
- **`generate-feature-map`**: Generate a verified `FEATURE_MAP.md` for a
  project.
- **`guardrail-audit`**: Audit soft rules and generate enforceable CI and
  static-analysis guardrails.

---

## 🚀 How to Invoke a Skill

When a task falls into one of these domains, the Controller should dispatch a sub-agent with the corresponding skill persona.

**Example Command:**
`@agent /as-security-expert [task description]`
