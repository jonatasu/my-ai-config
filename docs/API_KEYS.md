# API Keys Reference

This document provides detailed instructions for obtaining API keys for all supported services.

## 📋 Quick Links

**All API keys are optional** - you can skip any during installation and add them later.

| Service | Get API Key | Sign Up | Docs | Free Tier |
|---------|-------------|---------|------|-----------|
| **OpenRouter** | [Get Key](https://openrouter.ai/keys) | [Sign Up](https://openrouter.ai) | [Docs](https://openrouter.ai/docs) | $0.05 credits |
| **Groq** | [Get Key](https://console.groq.com/keys) | [Sign Up](https://console.groq.com) | [Docs](https://console.groq.com/docs) | Generous limits |
| **Context7** | [Get Key](https://context7.com) | [Sign Up](https://context7.com) | [Docs](https://context7.com/docs) | 100 queries/month |
| **Firecrawl** | [Get Key](https://firecrawl.dev) | [Sign Up](https://firecrawl.dev) | [Docs](https://docs.firecrawl.dev) | 500 pages/month |
| **TestSprite** | [Get Key](https://testsprite.com) | [Sign Up](https://testsprite.com) | [Docs](https://docs.testsprite.com) | Limited tests |
| **OpenAI** | [Get Key](https://platform.openai.com/api-keys) | [Sign Up](https://platform.openai.com/signup) | [Docs](https://platform.openai.com/docs) | $5 credits |
| **Google Gemini** | [Get Key](https://aistudio.google.com/app/apikey) | [Sign Up](https://ai.google.dev) | [Docs](https://ai.google.dev/docs) | Free tier |
| **Anthropic** | [Get Key](https://console.anthropic.com/settings/keys) | [Sign Up](https://console.anthropic.com) | [Docs](https://docs.anthropic.com) | $5 credits |
| **Atlassian** | [Create Token](https://id.atlassian.com/manage-profile/security/api-tokens) | [Sign Up](https://www.atlassian.com/try/cloud/signup) | [Docs](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/) | Free tier |

## 🚫 No API Key Needed

| Service | Installation | Purpose |
|---------|--------------|---------|
| **[Ollama](https://ollama.com/download)** | Local install | Local LLM inference (auto-detected) |
| **[Playwright](https://playwright.dev)** | Auto via npx | Browser automation |
| **[Repomix](https://github.com/yamadashy/repomix)** | Auto via npx | Repository packaging |

---

## 📝 Step-by-Step Instructions

### 🔹 OpenRouter

**Primary LLM provider for both OpenCode and OpenClaude**

1. Visit **[https://openrouter.ai](https://openrouter.ai)**
2. Click **"Sign In"** → Sign up with GitHub or email
3. Navigate to **[Keys](https://openrouter.ai/keys)** section
4. Click **"Create Key"**
5. Give it a name (e.g., "my-ai-config")
6. Copy the key (format: `sk-or-v1-...`)

**Pricing:** $0.05 starting credits, pay-as-you-go ($0.001-$0.01 per request depending on model)

**Models available:** Qwen 2.5 Coder, GPT-4o, Claude, Gemini, and 100+ more

---

### 🔹 Groq

**Fast inference for OpenClaude agent routing**

1. Visit **[https://console.groq.com](https://console.groq.com)**
2. Click **"Sign Up"** → Use Google or email
3. Go to **[API Keys](https://console.groq.com/keys)**
4. Click **"Create API Key"**
5. Name it (e.g., "my-ai-config")
6. Copy the key (format: `gsk_...`)

**Pricing:** Generous free tier (14,400 requests/day on Llama 3.3 70B)

**Models available:** Llama 3.3 70B, Mixtral 8x7B, Gemma 2 9B

---

### 🔹 Context7

**Documentation search MCP for libraries/frameworks**

1. Visit **[https://context7.com](https://context7.com)**
2. Click **"Get Started"** → Sign up with GitHub or email
3. Navigate to **Settings → API Keys**
4. Click **"Create New Key"**
5. Copy the key (format: `ctx7sk-...`)

**Pricing:** 100 queries/month free, then $10/month for unlimited

**Use cases:** Search React docs, Next.js docs, Python stdlib, etc.

---

### 🔹 Firecrawl

**Advanced web scraping and crawling MCP**

1. Visit **[https://firecrawl.dev](https://firecrawl.dev)**
2. Click **"Get Started"** → Sign up with GitHub or email
3. Go to **[Dashboard](https://firecrawl.dev/dashboard)** → API Keys
4. Click **"Create API Key"**
5. Copy the key (format: `fc-...`)

**Pricing:** 500 pages/month free, then $20/month for 5,000 pages

**Features:** JavaScript rendering, PDF extraction, structured data extraction

---

### 🔹 TestSprite

**AI-driven test generation MCP**

1. Visit **[https://testsprite.com](https://testsprite.com)**
2. Click **"Sign Up"** → Create account
3. Navigate to **Settings → API**
4. Click **"Generate API Key"**
5. Copy the key (format: `sk-user-...`)

**Pricing:** Limited free tests, then paid plans starting at $29/month

**Features:** Auto-generate tests for React, Vue, Angular, Node.js, Python, Go, Java

---

### 🔹 OpenAI

**Alternative LLM provider (GPT-4o, GPT-4 Turbo)**

1. Visit **[https://platform.openai.com](https://platform.openai.com)**
2. Click **"Sign Up"** or log in with existing account
3. Go to **[API Keys](https://platform.openai.com/api-keys)**
4. Click **"Create new secret key"**
5. Give it a name (e.g., "my-ai-config")
6. Copy the key (format: `sk-proj-...` or `sk-...`)

**Pricing:** $5 free credits for new accounts, then pay-as-you-go ($0.03-$0.10 per 1M tokens)

**Models available:** GPT-4o, GPT-4 Turbo, GPT-3.5 Turbo, o1-preview

---

### 🔹 Google Gemini

**Google's AI model for multimodal tasks**

1. Visit **[https://aistudio.google.com](https://aistudio.google.com)**
2. Sign in with your Google account
3. Click **"Get API key"** in the top navigation
4. Create a new project or select existing one
5. Click **"Create API key in new project"**
6. Copy the key (format: `AIza...`)

**Pricing:** Free tier with 60 requests/minute (1,500 requests/day)

**Models available:** Gemini 1.5 Pro, Gemini 1.5 Flash, Gemini 2.0 Flash

---

### 🔹 Anthropic

**Claude AI models (Claude 3.5 Sonnet, Claude 3 Opus)**

1. Visit **[https://console.anthropic.com](https://console.anthropic.com)**
2. Click **"Sign Up"** → Use email to create account
3. Navigate to **[API Keys](https://console.anthropic.com/settings/keys)**
4. Click **"Create Key"**
5. Name it (e.g., "my-ai-config")
6. Copy the key (format: `sk-ant-...`)

**Pricing:** $5 free credits for new accounts, then pay-as-you-go ($3-$15 per 1M tokens)

**Models available:** Claude 3.5 Sonnet, Claude 3 Opus, Claude 3 Haiku

---

### 🔹 Atlassian

**Jira/Confluence integration MCP**

1. Visit **[https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)**
2. Sign in with your Atlassian account
3. Click **"Create API token"**
4. Give it a label (e.g., "my-ai-config")
5. Copy the token (format: `ATATT3xFf...`)
6. **Encode as Basic Auth:** `echo -n "your-email@company.com:YOUR_TOKEN" | base64`
7. Use the base64 output as the API key in the installer

**Pricing:** Free for up to 10 users, paid plans from $8.15/user/month

**Use cases:** Query Jira issues, update tickets, search Confluence docs, link PRs to issues

---

## 🔒 Security Best Practices

1. **Never commit API keys** to Git repositories
   - The sync script automatically removes keys before committing
   - The `.gitignore` file blocks common secret files

2. **Rotate keys regularly**
   - Especially if you suspect they've been exposed
   - Most services allow multiple keys for rotation

3. **Use environment variables** for extra security (optional)
   - Can set keys in shell profile instead of config files
   - Installer supports reading from env vars

4. **Monitor usage**
   - Most services provide usage dashboards
   - Set up billing alerts for paid services

## ❓ Troubleshooting

### "Invalid API key" errors

1. Check the key format matches the examples above
2. Verify the key hasn't expired (check service dashboard)
3. Ensure you copied the full key (no truncation)
4. Some services require activation after signup

### "Rate limit exceeded" errors

1. Check your service usage dashboard
2. Free tiers have rate limits (requests per minute/day)
3. Consider upgrading to paid tier for higher limits
4. Wait for rate limit reset (usually hourly or daily)

### MCP servers not working

1. Verify the API key is set correctly in config files:
   - OpenCode: `~/.config/opencode/opencode.json`
   - OpenClaude: `~/.claude.json` and `~/.config/openclaude/openclaude.json`
2. Check MCP server is enabled (`"enabled": true`)
3. Test the key directly with the service's API docs
4. Restart the AI tool after changing keys

## 📧 Need Help?

- Check the service's documentation for API setup
- Most services have Discord/Slack communities
- Create an issue in this repo if the installer has problems

---

**Next Steps**: After collecting your keys, run `./install.sh` to configure the tools.
