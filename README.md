# My AI Config

Portable, cross-platform configurations for AI-powered CLI tools. Sync your custom commands, skills, and MCP servers across machines using Git.

## 🎯 Supported Tools

- ✅ **OpenCode** - AI coding assistant with custom commands and skills
- ✅ **OpenClaude** - Claude-powered terminal AI with agent routing
- 📄 **GitHub Copilot CLI** - Reference only (no config files to manage)

## 🚀 Quick Start

### Unix/Mac

```bash
git clone https://github.com/jonatasu/my-ai-config.git
cd my-ai-config
chmod +x install.sh
./install.sh
```

### Windows

See [docs/WINDOWS_SETUP.md](docs/WINDOWS_SETUP.md) for detailed instructions.

## ✨ Features

- 🔄 **Git-based sync** - Keep configs in sync across multiple machines
- 🔑 **Interactive API key setup** - Prompts for required and optional keys
- 🛡️ **Automatic backups** - Creates backup before overwriting existing configs
- 📦 **54 shared skills** (14MB) - Comprehensive skill library for both tools
- 🎯 **13 custom commands** - `/test`, `/commit`, `/refactor`, `/security`, etc.
- 🔌 **6 MCP servers** - Context7, Firecrawl, TestSprite, Playwright, Atlassian, Repomix
- 🤖 **Ollama support** - Auto-detects local models if Ollama is installed

## 📁 What's Included

```
my-ai-config/
├── configs/
│   ├── skills/                     # 54 shared skills (14MB)
│   ├── opencode/
│   │   └── opencode.json.template  # Commands, providers, MCPs
│   ├── openclaude/
│   │   ├── .claude.json.template           # Provider profiles, agent routing
│   │   ├── .openclaude-profile.json.template
│   │   └── openclaude.json.template        # Custom commands
│   └── copilot-cli/
│       └── gh-copilot-reference.md # Reference only
├── scripts/
│   ├── lib/                        # Helper libraries
│   ├── backup.sh                   # Backup utility
│   └── validate.sh                 # Config validator
├── docs/
│   ├── API_KEYS.md                 # Where to get API keys
│   ├── WINDOWS_SETUP.md            # Windows installation guide
│   ├── MIGRATION.md                # Migration history
│   └── TOOLS_COMPARISON.md         # Tool comparison reference
├── install.sh                      # Unix/Mac installer
├── install.ps1                     # Windows installer
├── sync.sh                         # Sync configs back to repo
└── sync.ps1                        # Windows sync script
```

## 🔑 API Keys & MCPs

The installer will prompt for API keys and MCP server selection.

### API Keys (all optional - press Enter to skip)
- **OpenRouter** - Primary LLM provider for both OpenCode and OpenClaude
- **Groq** - Fast inference for OpenClaude agent routing
- **Context7** - Documentation search MCP
- **Firecrawl** - Advanced web scraping MCP
- **TestSprite** - AI-driven test generation MCP
- **OpenAI** - Alternative LLM provider
- **Google Gemini** - Alternative LLM provider
- **Anthropic** - Alternative LLM provider (Claude)
- **Atlassian** - Jira/Confluence integration MCP

### MCP Servers (all optional - choose which to enable)
- **Context7** - Documentation search for libraries/frameworks
- **Firecrawl** - Advanced web scraping and crawling
- **Playwright** - Browser automation and testing (no API key needed)
- **TestSprite** - AI-driven test generation
- **Repomix** - Repository packaging for LLM analysis (no API key needed)
- **Atlassian** - Jira and Confluence integration

**Note:** Skills and custom commands are always installed by default.

See [docs/API_KEYS.md](docs/API_KEYS.md) for where to get these keys.

## 🔄 Syncing Changes

After making changes to your configs locally, sync them back to the repo:

```bash
./sync.sh  # Unix/Mac
# OR
.\sync.ps1 # Windows
```

This will:
1. Copy configs from system locations back to repo
2. **Remove API keys** (replaces with placeholders)
3. Prompt for commit message
4. Git commit + push to remote

## 📖 Documentation

- [API Keys Reference](docs/API_KEYS.md) - Where to get all API keys
- [Windows Setup Guide](docs/WINDOWS_SETUP.md) - Windows-specific instructions
- [Tools Comparison](docs/TOOLS_COMPARISON.md) - OpenCode vs OpenClaude vs Copilot CLI
- [Migration History](docs/MIGRATION.md) - Configuration evolution history

## 🛠️ Custom Commands

Both OpenCode and OpenClaude include these commands:

| Command | Description |
|---------|-------------|
| `/review-my-code` | Interactive code review of selected code |
| `/test` | Generate unit tests (uses TestSprite MCP if available) |
| `/refactor` | Suggest refactoring improvements |
| `/explain` | Explain code in detail |
| `/optimize` | Optimize code for performance |
| `/security` | Security audit |
| `/document` | Generate documentation |
| `/commit` | Create atomic semantic commits |
| `/pr` | Generate PR description |
| `/debug` | Help debug an issue |
| `/types` | Add/improve TypeScript types |
| `/scrape` | Scrape content from websites (uses Firecrawl MCP) |
| `/plan` | Create implementation plan *(OpenClaude only)* |

## 🔌 MCP Servers

Pre-configured MCP servers:

- **Context7** - Search documentation for any library/framework
- **Firecrawl** - Scrape and crawl websites
- **TestSprite** - AI-powered test generation
- **Playwright** - Browser automation for testing
- **Atlassian** - Jira and Confluence integration
- **Repomix** - Repository packaging for AI analysis

## 🤝 Contributing

This is a personal config repo, but feel free to fork and adapt for your own use!

## 📄 License

MIT License - See LICENSE file for details

## 🙏 Credits

- [OpenCode](https://opencode.ai) - AI coding assistant
- [OpenClaude](https://github.com/openclaude/openclaude) - Claude terminal AI
- Skills adapted from the OpenCode community

---

**Made with ❤️ for portable AI tooling**
