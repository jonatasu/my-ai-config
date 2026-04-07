# Windows Setup Guide

Complete installation guide for Windows users.

## Prerequisites

Before installing, ensure you have:

### Required Software

1. **PowerShell 5.1+** or **PowerShell Core 7+**
   - Check version: `$PSVersionTable.PSVersion`
   - Windows 10/11 comes with PowerShell 5.1
   - Download PowerShell 7: https://aka.ms/powershell

2. **Git for Windows**
   - Download: https://git-scm.com/download/win
   - Make sure "Git from the command line" is enabled

3. **Node.js 18+** (for MCP servers)
   - Download: https://nodejs.org
   - LTS version recommended
   - Verify: `node --version`

### Optional Software

- **Ollama for Windows** (if you want local models)
  - Download: https://ollama.com/download/windows
  - After install, run: `ollama run llama3.2`

## Installation

### Step 1: Clone Repository

Open PowerShell (or PowerShell Core) and run:

```powershell
# Clone the repo
git clone https://github.com/jonatasu/my-ai-config.git
cd my-ai-config
```

### Step 2: Run Installer

**Option A: Interactive Mode (Recommended)**

```powershell
.\install.ps1
```

This will show a menu asking which tools to configure (OpenCode, OpenClaude, or both).

**Option B: Automatic Mode**

```powershell
# Install both tools automatically
.\install.ps1 -Tools "both" -NonInteractive

# Install only OpenCode
.\install.ps1 -Tools "opencode" -NonInteractive

# Install only OpenClaude
.\install.ps1 -Tools "openclaude" -NonInteractive
```

### Step 3: Enter API Keys

The installer will prompt for API keys:

1. **Required keys** (cannot skip):
   - OpenRouter API key
   - Groq API key

2. **Optional keys** (press Enter to skip):
   - Context7, Firecrawl, TestSprite, OpenAI, Google, Anthropic, Atlassian

See [API_KEYS.md](API_KEYS.md) for where to get these keys.

### Step 4: Verify Installation

The installer will:
- Create backups of existing configs
- Copy templates to config directories
- Replace API key placeholders with your real keys
- Validate the installation

You should see:
```
✓ All checks passed!
✓ Installation complete!
```

## Configuration Paths

### OpenCode

- **Config file**: `%APPDATA%\opencode\opencode.json`
- **Skills**: `%APPDATA%\opencode\skills\` (54 skills, 14MB)

Example path: `C:\Users\YourName\AppData\Roaming\opencode\`

### OpenClaude

- **Main config**: `%USERPROFILE%\.claude.json`
- **Profile**: `%USERPROFILE%\.openclaude-profile.json`
- **Custom commands**: `%USERPROFILE%\.config\openclaude\openclaude.json`
- **Skills**: `%USERPROFILE%\.config\openclaude\skills\` (54 skills, 14MB)

Example paths:
- `C:\Users\YourName\.claude.json`
- `C:\Users\YourName\.config\openclaude\`

## Usage

### OpenCode

```powershell
# In VS Code or supported editors
# Use slash commands: /test, /commit, /refactor, etc.
```

### OpenClaude

```powershell
# From terminal
openclaude
# Then use slash commands
```

## Syncing Changes

After making changes to your configs locally, sync them back to the repo:

```powershell
cd path\to\my-ai-config
.\sync.ps1
```

This will:
1. Copy configs from system locations back to repo
2. Remove API keys (replaces with placeholders)
3. Prompt for commit message
4. Git commit + push to remote

## Troubleshooting

### "Running scripts is disabled on this system"

PowerShell execution policy error. Fix with:

```powershell
# Check current policy
Get-ExecutionPolicy

# Set to allow local scripts (as Administrator)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "git is not recognized"

Git is not in PATH. Fix:

1. Reinstall Git for Windows
2. During install, select "Git from the command line and also from 3rd-party software"
3. Or add Git manually to PATH:
   - Search "Environment Variables" in Windows
   - Edit System PATH
   - Add: `C:\Program Files\Git\cmd`

### "node is not recognized"

Node.js is not in PATH. Fix:

1. Reinstall Node.js (will add to PATH automatically)
2. Restart PowerShell after install
3. Verify: `node --version`

### "npx is not found" when using MCPs

1. Ensure Node.js 18+ is installed
2. `npx` comes with Node.js (bundled with npm)
3. Verify: `npx --version`
4. If missing, reinstall Node.js

### MCPs not working

1. Check config files have correct API keys:
   ```powershell
   notepad %APPDATA%\opencode\opencode.json
   notepad %USERPROFILE%\.claude.json
   ```

2. Ensure `"enabled": true` for each MCP

3. Test if npx can run MCP:
   ```powershell
   npx @playwright/mcp@latest
   # Should show "Server running" or similar
   ```

4. Restart the AI tool after config changes

### Ollama models not detected

1. Ensure Ollama is installed and running
2. Test Ollama:
   ```powershell
   ollama --version
   ollama list
   ```

3. If Ollama is installed but not detected, manually edit:
   - `%APPDATA%\opencode\opencode.json`
   - Update `provider.ollama.models` section with your models

4. Re-run installer and it should detect models

### Permission denied errors

Some paths require administrator access:

1. Run PowerShell as Administrator:
   - Right-click PowerShell
   - Select "Run as Administrator"

2. Or change install location to user directory (not recommended)

### Unicode/encoding issues in PowerShell

If you see garbled characters:

```powershell
# Set UTF-8 encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001
```

Add to your PowerShell profile to persist:

```powershell
notepad $PROFILE
# Add the encoding lines above
```

## Uninstallation

To remove the configs:

### OpenCode

```powershell
Remove-Item -Recurse -Force $env:APPDATA\opencode
```

### OpenClaude

```powershell
Remove-Item -Force $env:USERPROFILE\.claude.json
Remove-Item -Force $env:USERPROFILE\.openclaude-profile.json
Remove-Item -Recurse -Force $env:USERPROFILE\.config\openclaude
```

### Restore from Backup

Backups are created at: `%USERPROFILE%\.ai-config-backups\<timestamp>\`

To restore:

```powershell
# List backups
dir $env:USERPROFILE\.ai-config-backups

# Restore from backup (replace timestamp)
Copy-Item -Recurse $env:USERPROFILE\.ai-config-backups\20250407_123456\* $env:APPDATA\
```

## Differences from Unix/Mac

| Feature | Unix/Mac | Windows |
|---------|----------|---------|
| Config paths | `~/.config/` | `%APPDATA%\` or `%USERPROFILE%\.config\` |
| Scripts | `.sh` (bash) | `.ps1` (PowerShell) |
| Line endings | LF | CRLF (Git handles automatically) |
| Ollama install | Easy via package managers | Manual installer |
| Execution policy | Not needed | May need `Set-ExecutionPolicy` |

## Tips for Windows Users

1. **Use Windows Terminal** instead of cmd.exe
   - Better colors, tabs, Unicode support
   - Download: Microsoft Store

2. **Enable long paths** (Windows 10 1607+):
   ```powershell
   # As Administrator
   New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
   ```

3. **Use PowerShell 7** (pwsh) instead of PowerShell 5.1
   - Modern, cross-platform, better performance
   - Download: https://aka.ms/powershell

4. **Git line endings** (already handled by .gitattributes):
   ```powershell
   git config --global core.autocrlf true
   ```

## Need More Help?

- Check PowerShell help: `Get-Help about_Execution_Policies`
- Git for Windows docs: https://gitforwindows.org
- Node.js Windows FAQ: https://nodejs.org/en/docs/guides
- Create an issue: https://github.com/jonatasu/my-ai-config/issues

---

**Next Steps**: After installation, try the custom commands like `/test`, `/commit`, `/refactor` in your AI tool!
