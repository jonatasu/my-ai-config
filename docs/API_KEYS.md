# API Keys Reference

This document lists all API keys used by the AI tools and where to obtain them.

## 🔴 Required Keys

These keys are **required** during installation and cannot be skipped:

| Service | Where to Get | Used By | Notes |
|---------|--------------|---------|-------|
| **OpenRouter** | https://openrouter.ai/keys | OpenCode, OpenClaude | Primary provider for Qwen Coder model |
| **Groq** | https://console.groq.com/keys | OpenClaude | Used for agent routing (Llama 3.3 70B) |

## 🟡 Optional Keys

These keys can be skipped during installation by pressing Enter. You can add them later by editing the config files.

### MCP Server Keys

| Service | Where to Get | Used By | Purpose |
|---------|--------------|---------|---------|
| **Context7** | https://context7.com | MCP | Search documentation for any library/framework |
| **Firecrawl** | https://firecrawl.dev | MCP | Web scraping and crawling |
| **TestSprite** | https://testsprite.com | MCP | AI-powered test generation |
| **Atlassian** | Jira/Confluence Settings → API Tokens | MCP | Jira and Confluence integration |

### Provider Keys (OpenClaude Only)

| Service | Where to Get | Used By | Purpose |
|---------|--------------|---------|---------|
| **OpenAI** | https://platform.openai.com/api-keys | OpenClaude | GPT-4o model access |
| **Google Gemini** | https://aistudio.google.com/apikey | OpenClaude | Gemini 2.0 Flash model |
| **Anthropic** | https://console.anthropic.com/keys | OpenClaude | Claude Sonnet 4.5 model |

## 🟢 No API Key Needed

| Service | Installation | Used By | Purpose |
|---------|--------------|---------|---------|
| **Ollama** | https://ollama.com/download | OpenCode | Local LLM inference (models auto-detected) |
| **Playwright** | Auto-installed via npx | MCP | Browser automation (no signup required) |
| **Repomix** | Auto-installed via npx | MCP | Repository packaging (no signup required) |

## 📝 How to Get API Keys

### OpenRouter (Required)

1. Go to https://openrouter.ai
2. Sign up with GitHub or email
3. Navigate to **Keys** section
4. Click **Create Key**
5. Copy the key (starts with `sk-or-v1-...`)

**Free tier**: $0.05 credits to start, pay-as-you-go after

### Groq (Required)

1. Go to https://console.groq.com
2. Sign up with Google or email
3. Navigate to **API Keys**
4. Click **Create API Key**
5. Copy the key (starts with `gsk_...`)

**Free tier**: Generous free tier with rate limits

### Context7 (Optional)

1. Go to https://context7.com
2. Sign up with GitHub or email
3. Navigate to **Settings → API Keys**
4. Create a new key
5. Copy the key (starts with `ctx7sk-...`)

**Free tier**: 100 queries/month free

### Firecrawl (Optional)

1. Go to https://firecrawl.dev
2. Sign up with GitHub or email
3. Navigate to **API Keys** in dashboard
4. Create a new key
5. Copy the key (starts with `fc-...`)

**Free tier**: 500 pages/month free

### TestSprite (Optional)

1. Go to https://testsprite.com
2. Sign up for account
3. Navigate to **Settings → API**
4. Generate API key
5. Copy the key (starts with `sk-user-...`)

**Free tier**: Limited free tests available

### OpenAI (Optional)

1. Go to https://platform.openai.com
2. Sign up or login
3. Navigate to **API Keys**
4. Click **Create new secret key**
5. Copy the key (starts with `sk-proj-...` or `sk-...`)

**Free tier**: $5 credit for new accounts

### Google Gemini (Optional)

1. Go to https://aistudio.google.com
2. Sign in with Google account
3. Click **Get API key**
4. Create new project or use existing
5. Copy the API key (starts with `AIza...`)

**Free tier**: 60 requests/minute free

### Anthropic (Optional)

1. Go to https://console.anthropic.com
2. Sign up with email
3. Navigate to **API Keys**
4. Click **Create Key**
5. Copy the key (UUID format)

**Free tier**: Trial credits for new accounts

### Atlassian/Jira (Optional)

1. Go to your Jira instance (e.g., `yourcompany.atlassian.net`)
2. Click profile → **Account settings**
3. Navigate to **Security → API tokens**
4. Click **Create API token**
5. Copy the token
6. Encode as Basic Auth: `echo -n "your-email@company.com:TOKEN" | base64`

**Free tier**: Depends on your organization's plan

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
