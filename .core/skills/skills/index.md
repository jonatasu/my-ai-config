# 🧠 JOW-AI Skill Catalog

This is a comprehensive catalog of professional expertise modules. An AI agent can scan this catalog to quickly identify and invoke the most specialized skill required to fulfill a user's request.

## 🛠️ Engineering & Development
- **`code-quality`**: Enforces clean code principles and industry-standard development practices. (Keywords: clean code, SOLID, DRY, code audit)
- **`code-review`**: Performs comprehensive, multi-dimensional reviews of software changes. (Keywords: code review, vulnerability, performance, quality)
- **`refactoring`**: Systematically improves existing code structures without altering external behavior. (Keywords: refactor, technical debt, code smells)
- **`typescript`**: Leverages static typing to improve code reliability and maintainability. (Keywords: typescript, type safety, interfaces, generics)
- **`debugging`**: Provides systematic troubleshooting and error resolution within complex systems. (Keywords: debug, fix bug, troubleshooting, error resolution)
- **`testing`**: Ensures software reliability and correctness through systematic testing strategies. (Keywords: testing, unit test, edge cases, AAA pattern)
- **`test-driven-development`**: Implements a development methodology where tests are written before implementation. (Keywords: TDD, test-driven, red-green-refactor)
- **`systematic-debugging`**: Applies a rigorous, scientific approach to identifying root causes of technical issues. (Keywords: root cause, scientific debugging, investigation)
- **`subagent-driven-development`**: Orchestrates specialized, isolated subagents to implement complex, multi-task plans. (Keywords: subagent, orchestration, parallel development)
- **`composition-patterns`**: Designs flexible, scalable, and maintainable UI component architectures. (Keywords: component architecture, composition, prop drilling)
- **`mcp-builder`**: Designs and implements standardized interfaces for LLMs to interact with external services. (Keywords: MCP, tool-use, model-to-service)

## 🎨 Design & Creative
- **`ui-ux-pro-max`**: Provides high-fidelity UI and UX design for web and mobile applications. (Keywords: UI/UX, design, user experience, usability)
- **`frontend-design`**: Creates distinctive, production-grade user interfaces with high design quality. (Keywords: frontend design, UI, interface, aesthetic)
- **`ui-styling`**: Creates beautiful, accessible, and responsive user interfaces using component-based architectures. (Keywords: UI styling, CSS, Tailwind, responsive)
- **`web-design-guidelines`**: Reviews UI code against Web Interface Guidelines. (Keywords: design review, accessibility, UX audit)
- **`banner-design`**: Creates high-impact visual banners for social media, digital advertising, and more. (Keywords: banner, ad design, social media graphic)
- **`algorithmic-art`**: Creates generative and algorithmic art using computational philosophies. (Keywords: generative art, algorithmic art, p5.js)
- **`design`**: Comprehensive design skill covering brand identity, design tokens, and logo generation. (Keywords: design, logo, design system)
- **`design-system`**: Focuses on token architecture, component specifications, and systematic design. (Keywords: design system, design tokens, component specs)

## 📄 Documentation & Content
- **`documentation`**: Follows best practices for API docs, README templates, and JSDoc/TSDoc patterns. (Keywords: documentation, docs, README, API documentation)
- **`doc-coauthoring`**: Guides users through a structured workflow for co-authoring technical documentation. (Keywords: co-authoring, technical writing, documentation workflow)
- **`writing-plans`**: Used for creating detailed implementation plans for multi-step tasks. (Keywords: writing plan, implementation plan, specification)
- **`writing-skills`**: Used for creating, editing, or optimizing specialized agentic skills. (Keywords: writing skills, skill development, instruction optimization)
- **`docx`**: Handles creation, reading, editing, or manipulation of Word documents. (Keywords: Word, docx, document editing)
- **`pptx`**: Handles creation, analysis, or modification of professional presentation decks. (Keywords: PowerPoint, pptx, presentation, slide deck)
- **`pdf`**: Manages extraction, manipulation, and creation of PDF files. (Keywords: PDF, document extraction, OCR, PDF merge)

## 📊 Data & Automation
- **`web-scraping`**: Strategies and tools for extracting data from websites. (Keywords: web scraping, data extraction, firecrawl)
- **`xlsx`**: Handles spreadsheets including .xlsx, .csv, and .tsv files. (Keywords: excel, xlsx, spreadsheet, csv)
- **`brainstorming`**: Transforms nebulous ideas into structured, actionable design specifications. (Keywords: brainstorm, ideation, requirement exploration)
- **`brand`**: Manages brand identity, voice, visual identity, and messaging frameworks. (Keywords: brand, identity, brand voice)
- **`brand-guidelines`**: Ensures all artifacts strictly adhere to established corporate identity standards. (Keywords: brand guidelines, brand compliance, visual identity)

## 🚀 Deployment & DevOps
- **`deploy-to-vercel`**: Streamlines the deployment of applications and web projects to Vercel. (Keywords: deploy, vercel, hosting)
- **`vercel-cli-with-tokens`**: Manages Vercel deployment and management using token-based authentication. (Keywords: vercel cli, deployment token)
- **`vercel-composition-patterns`**: Focuses on React composition patterns that scale within the Vercel ecosystem. (Keywords: vercel composition, react patterns)
- **`vercel-react-best-practices`**: Optimizes React and Next.js performance based on Vercel engineering guidelines. (Keywords: vercel react, performance, next.js)
- **`vercel-react-native-skills`**: Focuses on React Native and Expo best practices for mobile applications. (Keywords: vercel react native, expo, mobile)
- **`git-workflow`**: Manages source code history and collaborative development workflows. (Keywords: git, commit, branch, workflow)
- **`using-git-worktrees`**: Manages multiple, isolated development environments using git worktrees. (Keywords: git worktree, isolated environment, branch management)

## 🛡️ Security & Quality
- **`security-audit`**: Conducts systematic audits to identify and remediate security vulnerabilities. (Keywords: security, audit, vulnerability, CVE)
- **`confidence-check`**: Performs rigorous readiness assessments before technical implementation. (Keywords: confidence check, readiness assessment, risk mitigation)
- **`verification-before-completion`**: Ensures work is verified with commands and output before claiming completion. (Keywords: verification, completion check, testing)

## 🤖 Agent Decision Protocol

- **Ambiguity**: If a request is ambiguous, use the `brainstorming` skill first to clarify requirements.
- **Multiple Matches**: If a user request matches multiple skills, list the available options and ask for clarification.
- **Specialization**: Always prioritize the most specialized skill for a given task (e.g., use `react-best-practices` instead of generic `code-quality` for React performance issues).
