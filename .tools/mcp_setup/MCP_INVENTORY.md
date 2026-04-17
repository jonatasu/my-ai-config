# 🛠️ MCP Tool Inventory & Configuration Guide

This document serves as the master catalog of Model Context Protocol (MCP) tools available to the JOW-AI ecosystem. It defines the capabilities of each tool and provides the necessary instructions for an agent (or human) to configure them.

---

## 🚀 Quick Start for Agents

When you encounter a task that requires external data, web interaction, or specialized tool execution, consult this inventory to identify the appropriate MCP.

**To enable a tool:**
1. Obtain the required API Key/Token from the links provided below.
2. Add the key to your environment variables (e.g., `.env` or system env).
3. Ensure the MCP server for that tool is running/active in your session.

---

## 🔍 Data & Web Intelligence

### 1. Firecrawl (Web Scraping & Crawling)
*Best for: Extracting structured data from websites and deep crawling.*

- **Capabilities**: 
    - Scrape single pages into Markdown/JSON.
    - Crawl entire domains to map site structure.
    - Bypass anti-bot measures.
- **Agent Persona**: `Web Researcher`
- **Setup Guide**:
    1. Go to [Firecrawl Dashboard](https://www.firecrawl.dev/).
    2. Sign up and generate an API Key.
    3. Set environment variable: `FIRECRAWL_API_KEY`.

### 2. Context7 (Deep Documentation Search)
*Best for: Finding precise technical answers in official documentation.*

- **Capabilities**: 
    - Semantic search across indexed library docs (React, Next.js, etc.).
    - Retrieve high-quality code snippets.
- **Agent Persona**: `Technical Librarian`
- **Setup Guide**:
    1. Access [Context7 Documentation](https://context7.com/).
    2. Generate your API Token.
    3. Set environment variable: `CONTEXT7_API_KEY`.

---

## 📊 Analytics & Product Intelligence

### 3. PostHog (Product Analytics & Event Tracking)
*Best for: Understanding user behavior, feature adoption, and production telemetry.*

- **Capabilities**: 
    - Query event data to verify feature impact.
    - Retrieve user session replays to debug UI friction.
    - Analyze funnel conversion rates.
    - Check feature flag status in real-time.
- **Agent Persona**: `Product Analyst`
- **Setup Guide**:
    1. Log in to your [PostHog Instance](httpss://app.posthog.com/).
    2. Navigate to **Project Settings** -> **Personal API Keys**.
    3. Generate a new key.
    4. Set environment variable: `POSTHOG_API_KEY`.
    5. (Optional) Provide `POSTHOG_PROJECT_ID` for specific project targeting.

---

## 🧪 Testing & Quality Assurance

### 4. TestSprite (AI-Driven Testing)
*Best for: Autonomous generation and execution of end-to-end tests.*

- **Capabilities**: 
    - Auto-generate test plans based on code changes.
    - Execute browser-based E2E tests.
    - Provide automated bug reports and fix suggestions.
- **Agent Persona**: `QA Engineer`
- **Setup Guide**:
    1. Access your [TestSprite Dashboard](https://testsprite.com/).
    2. Retrieve your API Token from settings.
    3. Set environment variable: `TESTSPRITE_API_KEY`.

---

## 🛠️ Development & Infrastructure

### 5. Vercel CLI (Deployment & Preview)
*Best for: Managing deployments and inspecting production environments.*

- **Capabilities**: 
    - Trigger production/preview deployments.
    - Manage environment variables.
    - Inspect deployment logs.
- **Agent Persona**: `DevOps Engineer`
- **Setup Guide**:
    1. Install Vercel CLI: `npm i -g vercel`.
    2. Login via CLI: `vercel login`.
    3. Use the session token or set `VERCEL_TOKEN` from your Vercel Dashboard.

### 6. GitHub MCP (Repository Management)
*Best for: Managing PRs, issues, and repository state.*

- **Capabilities**: 
    - Create/Comment on Pull Requests.
    - Manage GitHub Issues.
    - Search code across the organization.
- **Agent Persona**: `Maintainer`
- **Setup Guide**:
    1. Generate a **Personal Access Token (classic)** at [GitHub Settings](https://github.com/settings/tokens).
    2. Ensure `repo` scope is selected.
    3. Set environment variable: `GITHUB_PERSONAL_ACCESS_TOKEN`.

---

## 📝 Integration Checklist for Agents

When you are tasked with using a new tool, follow this internal checklist:
- [ ] **Auth Check**: Do I have the required API Key in my environment?
- [ ] **Scope Check**: Is the tool's capability aligned with the task requirements?
- [ ] **Safety Check**: Am use the tool in a way that respects data privacy (no PII leakage)?
- [ ] **Verification**: Did the tool return the expected structured data (JSON/Markdown)?
