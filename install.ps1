# PowerShell installer for my-ai-config
# Installs portable AI tool configurations with interactive setup

# Requires PowerShell 5.1 or later
#Requires -Version 5.1

# Stop on errors
$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = $ScriptDir

# Import helper functions
. "$ScriptDir\scripts\lib\common.ps1"
. "$ScriptDir\scripts\lib\api-keys.ps1"

# Banner
Write-Host ""
Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   My AI Config - Installer v1.0      ║" -ForegroundColor Cyan
Write-Host "║   Portable configs for AI CLI tools  ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Detect OS
$OS = Get-OperatingSystem
Write-Info "Detected OS: $OS"
Write-Host ""

# Check prerequisites
Write-Step "Checking prerequisites..."
Test-Command "git" "Install from https://git-scm.com"
Test-Command "node" "Install from https://nodejs.org (required for MCP servers)"
Write-Info "All prerequisites met"
Write-Host ""

# Interactive menu
Write-Host "Which tools do you want to configure?"
Write-Host "  1) OpenCode only"
Write-Host "  2) OpenClaude only"
Write-Host "  3) Both OpenCode and OpenClaude (default)"
Write-Host ""
$choice = Read-Host "Enter choice [1-3] (default: 3)"
if ([string]::IsNullOrWhiteSpace($choice)) { $choice = "3" }

$InstallOpenCode = $false
$InstallOpenClaude = $false

switch ($choice) {
    "1" {
        $InstallOpenCode = $true
        Write-Info "Installing: OpenCode"
    }
    "2" {
        $InstallOpenClaude = $true
        Write-Info "Installing: OpenClaude"
    }
    default {
        $InstallOpenCode = $true
        $InstallOpenClaude = $true
        Write-Info "Installing: OpenCode + OpenClaude"
    }
}
Write-Host ""

# Backup existing configs
& "$ScriptDir\scripts\backup.ps1"

# Collect API keys
Write-Step "API Key Setup"
Write-Host "See docs\API_KEYS.md for where to get these keys"
Write-Host ""

$ApiKeys = Get-ApiKeys
$McpSelections = Get-McpSelections

Show-KeysSummary -ApiKeys $ApiKeys

# Check Ollama
$OllamaStatus = Test-Ollama
if ($OllamaStatus -eq "detected") {
    Write-Info "Ollama detected! Fetching installed models..."
    $OllamaModels = Get-OllamaModels
    if ($OllamaModels.Count -gt 0) {
        Write-Info "Found Ollama models:"
        foreach ($model in $OllamaModels) {
            Write-Host "  - $model"
        }
        Write-Warning "Note: Using default models in template (customize later if needed)"
    }
    Write-Host ""
} else {
    Write-Warning "Ollama not found - using default models in template"
    Write-Warning "Install Ollama from https://ollama.com if you want local models"
    Write-Host ""
}

# Install OpenCode
if ($InstallOpenCode) {
    Write-Step "Installing OpenCode configuration..."
    
    $ConfigDir = Join-Path $env:USERPROFILE ".config\opencode"
    New-DirectoryIfNotExists -Path $ConfigDir
    
    # Copy skills
    Write-Info "Copying 54 skills (14MB)..."
    $SkillsSource = Join-Path $RepoDir "configs\skills"
    $SkillsDest = Join-Path $ConfigDir "skills"
    if (Test-Path $SkillsDest) {
        Remove-Item -Path $SkillsDest -Recurse -Force
    }
    Copy-Item -Path $SkillsSource -Destination $SkillsDest -Recurse -ErrorAction Stop
    
    # Copy and configure config file
    Write-Info "Creating opencode.json..."
    $TemplateFile = Join-Path $RepoDir "configs\opencode\opencode.json.template"
    $ConfigFile = Join-Path $ConfigDir "opencode.json"
    Copy-Item -Path $TemplateFile -Destination $ConfigFile -Force
    
    # Replace API keys
    Set-ApiKeysInFile -FilePath $ConfigFile -ApiKeys $ApiKeys
    
    # Apply MCP selections
    Set-McpSelectionsInFile -FilePath $ConfigFile -McpSelections $McpSelections
    
    Write-Info "✓ OpenCode installed at $ConfigDir"
    Write-Host ""
}

# Install OpenClaude
if ($InstallOpenClaude) {
    Write-Step "Installing OpenClaude configuration..."
    
    $ConfigDir = Join-Path $env:USERPROFILE ".config\openclaude"
    New-DirectoryIfNotExists -Path $ConfigDir
    
    # Copy skills
    Write-Info "Copying 54 skills (14MB)..."
    $SkillsSource = Join-Path $RepoDir "configs\skills"
    $SkillsDest = Join-Path $ConfigDir "skills"
    if (Test-Path $SkillsDest) {
        Remove-Item -Path $SkillsDest -Recurse -Force
    }
    Copy-Item -Path $SkillsSource -Destination $SkillsDest -Recurse -ErrorAction Stop
    
    # Copy main config
    Write-Info "Creating .claude.json..."
    $ClaudeTemplate = Join-Path $RepoDir "configs\openclaude\.claude.json.template"
    $ClaudeConfig = Join-Path $env:USERPROFILE ".claude.json"
    Copy-Item -Path $ClaudeTemplate -Destination $ClaudeConfig -Force
    Set-ApiKeysInFile -FilePath $ClaudeConfig -ApiKeys $ApiKeys
    
    # Replace /Users/YOUR_USERNAME with actual home
    Replace-InFile -FilePath $ClaudeConfig -Find "/Users/YOUR_USERNAME" -Replace $env:USERPROFILE.Replace('\', '/')
    
    # Apply MCP selections for OpenClaude
    Set-McpSelectionsInFileOpenClaude -FilePath $ClaudeConfig -McpSelections $McpSelections
    
    # Copy profile
    Write-Info "Creating .openclaude-profile.json..."
    $ProfileTemplate = Join-Path $RepoDir "configs\openclaude\.openclaude-profile.json.template"
    $ProfileConfig = Join-Path $env:USERPROFILE ".openclaude-profile.json"
    Copy-Item -Path $ProfileTemplate -Destination $ProfileConfig -Force
    Set-ApiKeysInFile -FilePath $ProfileConfig -ApiKeys $ApiKeys
    
    # Copy custom commands
    Write-Info "Creating openclaude.json..."
    $CommandsTemplate = Join-Path $RepoDir "configs\openclaude\openclaude.json.template"
    $CommandsConfig = Join-Path $ConfigDir "openclaude.json"
    Copy-Item -Path $CommandsTemplate -Destination $CommandsConfig -Force
    
    Write-Info "✓ OpenClaude installed at $ConfigDir and $env:USERPROFILE"
    Write-Host ""
}

# Validate installation
& "$ScriptDir\scripts\validate.ps1"

# Success message
Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║     ✓ Installation Complete!         ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

if ($InstallOpenCode) {
    Write-Host "OpenCode:"
    Write-Host "  Config: $env:USERPROFILE\.config\opencode\opencode.json"
    Write-Host "  Skills: $env:USERPROFILE\.config\opencode\skills\ (54 skills)"
    Write-Host ""
}

if ($InstallOpenClaude) {
    Write-Host "OpenClaude:"
    Write-Host "  Config: $env:USERPROFILE\.claude.json"
    Write-Host "  Profile: $env:USERPROFILE\.openclaude-profile.json"
    Write-Host "  Commands: $env:USERPROFILE\.config\openclaude\openclaude.json"
    Write-Host "  Skills: $env:USERPROFILE\.config\openclaude\skills\ (54 skills)"
    Write-Host ""
}

Write-Host "Next Steps:"
Write-Host "  1. Start your AI tool (OpenCode/OpenClaude)"
Write-Host "  2. Try custom commands: /test, /commit, /refactor, etc."
Write-Host "  3. Edit configs to add skipped API keys if needed"
Write-Host "  4. Run '.\sync.ps1' to sync changes back to repo"
Write-Host ""
Write-Host "Documentation:"
Write-Host "  - API Keys: $RepoDir\docs\API_KEYS.md"
Write-Host "  - Tools Comparison: $RepoDir\docs\TOOLS_COMPARISON.md"
Write-Host ""
Write-Info "Happy coding! 🚀"
Write-Host ""
