# GitHub Copilot CLI - Reference Only

**Note:** GitHub Copilot CLI does not have separate configuration files like OpenCode or OpenClaude.

## How Copilot CLI Works

GitHub Copilot CLI runs through the `gh` CLI tool and uses:
- GitHub account settings
- `gh` CLI authentication
- VS Code/IDE extensions for additional features

## Configuration Location

Copilot settings are managed through:
- **GitHub CLI**: `gh` configuration (`~/.config/gh/`)
- **GitHub Account**: Settings at github.com
- **IDE Extensions**: VS Code, JetBrains, etc.

## No Custom Commands

Unlike OpenCode and OpenClaude, Copilot CLI does not support:
- Custom command definitions (like `/test`, `/commit`, etc.)
- Local MCP server integrations
- Custom provider configurations
- Shared skills directories

## For Comparison

If you want to see how similar patterns could work, check:
- `../opencode/opencode.json.template` - Custom commands and MCP configs
- `../openclaude/.claude.json.template` - Provider profiles and agent routing

## Usage

To use GitHub Copilot CLI:
```bash
gh copilot suggest "your query"
gh copilot explain "code or command"
```

## Why This Is Reference Only

This directory exists to document that Copilot CLI was considered but:
1. It has no portable configuration files to manage
2. All settings are tied to your GitHub account
3. No installation/sync needed for this tool in this repo

For actual AI CLI tools with portable configs, use **OpenCode** or **OpenClaude**.
