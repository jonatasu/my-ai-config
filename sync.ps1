# Sync local configuration changes back to repository
# Removes API keys before committing

# Stop on errors
$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = $ScriptDir

# Import common functions
. "$ScriptDir\scripts\lib\common.ps1"

# Banner
Write-Host ""
Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Config Sync - Back to Repository   ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if in git repo
if (-not (Test-Path -Path (Join-Path $RepoDir ".git"))) {
    Write-Error "Not a git repository. Run this from the repo root."
}

# Sanitize file (remove API keys)
function Remove-ApiKeysFromFile {
    param(
        [string]$SourcePath,
        [string]$DestPath
    )
    
    if (-not (Test-Path -Path $SourcePath)) {
        Write-Warning "Source file not found: $SourcePath"
        return $false
    }
    
    Write-Step "Sanitizing $(Split-Path -Leaf $SourcePath)..."
    
    # Read file content
    $content = Get-Content -Path $SourcePath -Raw
    
    # Replace API keys with placeholders using regex
    $patterns = @{
        '"apiKey":\s*"[^"]*"' = '"apiKey": "YOUR_API_KEY"'
        '"api_key":\s*"[^"]*"' = '"api_key": "YOUR_API_KEY"'
        '"API_KEY":\s*"[^"]*"' = '"API_KEY": "YOUR_API_KEY"'
        '"OPENAI_API_KEY":\s*"[^"]*"' = '"OPENAI_API_KEY": "YOUR_OPENROUTER_API_KEY"'
        '"OPENROUTER_API_KEY":\s*"[^"]*"' = '"OPENROUTER_API_KEY": "YOUR_OPENROUTER_API_KEY"'
        '"GROQ_API_KEY":\s*"[^"]*"' = '"GROQ_API_KEY": "YOUR_GROQ_API_KEY"'
        '"CONTEXT7_API_KEY":\s*"[^"]*"' = '"CONTEXT7_API_KEY": "YOUR_CONTEXT7_API_KEY"'
        '"FIRECRAWL_API_KEY":\s*"[^"]*"' = '"FIRECRAWL_API_KEY": "YOUR_FIRECRAWL_API_KEY"'
        '"Authorization":\s*"Basic [^"]*"' = '"Authorization": "YOUR_ATLASSIAN_AUTH_TOKEN"'
        '"ATLASSIAN_AUTH":\s*"Basic [^"]*"' = '"ATLASSIAN_AUTH": "YOUR_ATLASSIAN_AUTH_TOKEN"'
        'sk-[a-zA-Z0-9_-]+' = 'YOUR_API_KEY'
        'gsk_[a-zA-Z0-9_-]+' = 'YOUR_GROQ_API_KEY'
        'fc-[a-zA-Z0-9_-]+' = 'YOUR_FIRECRAWL_API_KEY'
        'ctx7sk-[a-zA-Z0-9_-]+' = 'YOUR_CONTEXT7_API_KEY'
        'AIza[a-zA-Z0-9_-]+' = 'YOUR_GOOGLE_API_KEY'
    }
    
    foreach ($pattern in $patterns.Keys) {
        $content = $content -replace $pattern, $patterns[$pattern]
    }
    
    # Write sanitized content
    Set-Content -Path $DestPath -Value $content -NoNewline
    
    Write-Info "✓ Sanitized $(Split-Path -Leaf $DestPath)"
    return $true
}

# Sync OpenCode configs
function Sync-OpenCodeConfig {
    $ConfigDir = Join-Path $env:USERPROFILE ".config\opencode"
    
    if (-not (Test-Path -Path $ConfigDir)) {
        Write-Warning "OpenCode not installed, skipping"
        return
    }
    
    Write-Step "Syncing OpenCode configuration..."
    
    # Sync config file
    $ConfigFile = Join-Path $ConfigDir "opencode.json"
    if (Test-Path -Path $ConfigFile) {
        $DestFile = Join-Path $RepoDir "configs\opencode\opencode.json.template"
        Remove-ApiKeysFromFile -SourcePath $ConfigFile -DestPath $DestFile
    }
    
    # Sync skills (if changed)
    $SkillsSource = Join-Path $ConfigDir "skills"
    $SkillsDest = Join-Path $RepoDir "configs\skills"
    
    if (Test-Path -Path $SkillsSource) {
        Write-Info "Syncing skills directory..."
        
        # Create destination if doesn't exist
        New-DirectoryIfNotExists -Path $SkillsDest
        
        # Use robocopy for mirroring (similar to rsync)
        $result = robocopy $SkillsSource $SkillsDest /MIR /NFL /NDL /NJH /NJS /nc /ns /np 2>&1
        if ($LASTEXITCODE -le 7) {
            # Robocopy exit codes 0-7 are success or warnings
            Write-Info "✓ Skills synced"
        } else {
            Write-Warning "Skills sync had warnings (may be okay)"
        }
    }
    
    Write-Host ""
}

# Sync OpenClaude configs
function Sync-OpenClaudeConfig {
    $ClaudeJson = Join-Path $env:USERPROFILE ".claude.json"
    $ProfileJson = Join-Path $env:USERPROFILE ".openclaude-profile.json"
    $ConfigDir = Join-Path $env:USERPROFILE ".config\openclaude"
    
    $hasConfig = (Test-Path -Path $ClaudeJson) -or (Test-Path -Path $ProfileJson) -or (Test-Path -Path $ConfigDir)
    
    if (-not $hasConfig) {
        Write-Warning "OpenClaude not installed, skipping"
        return
    }
    
    Write-Step "Syncing OpenClaude configuration..."
    
    # Sync main config
    if (Test-Path -Path $ClaudeJson) {
        $DestFile = Join-Path $RepoDir "configs\openclaude\.claude.json.template"
        Remove-ApiKeysFromFile -SourcePath $ClaudeJson -DestPath $DestFile
    }
    
    # Sync profile
    if (Test-Path -Path $ProfileJson) {
        $DestFile = Join-Path $RepoDir "configs\openclaude\.openclaude-profile.json.template"
        Remove-ApiKeysFromFile -SourcePath $ProfileJson -DestPath $DestFile
    }
    
    # Sync custom commands (no API keys, just copy)
    $CommandsFile = Join-Path $ConfigDir "openclaude.json"
    if (Test-Path -Path $CommandsFile) {
        $DestFile = Join-Path $RepoDir "configs\openclaude\openclaude.json.template"
        Copy-Item -Path $CommandsFile -Destination $DestFile -Force
        Write-Info "✓ Synced openclaude.json"
    }
    
    # Sync skills (if changed) - only if different from OpenCode
    $SkillsSource = Join-Path $ConfigDir "skills"
    $OpenCodeSkills = Join-Path $env:USERPROFILE ".config\opencode\skills"
    
    if ((Test-Path -Path $SkillsSource) -and (-not (Test-Path -Path $OpenCodeSkills))) {
        Write-Info "Syncing skills from OpenClaude..."
        $SkillsDest = Join-Path $RepoDir "configs\skills"
        New-DirectoryIfNotExists -Path $SkillsDest
        
        $result = robocopy $SkillsSource $SkillsDest /MIR /NFL /NDL /NJH /NJS /nc /ns /np 2>&1
        if ($LASTEXITCODE -le 7) {
            Write-Info "✓ Skills synced"
        } else {
            Write-Warning "Skills sync had warnings"
        }
    }
    
    Write-Host ""
}

# Perform sync
Sync-OpenCodeConfig
Sync-OpenClaudeConfig

# Git status
Write-Step "Checking for changes..."

Push-Location $RepoDir
try {
    $status = git status --porcelain 2>&1
    
    if ([string]::IsNullOrWhiteSpace($status)) {
        Write-Info "No changes to commit"
        Write-Host ""
        exit 0
    }
    
    Write-Host ""
    git status --short
    Write-Host ""
    
    # Prompt for commit message
    $commitMsg = Read-Host "Commit message (default: 'sync: update configs')"
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $commitMsg = "sync: update configs"
    }
    
    # Git operations
    Write-Step "Committing changes..."
    git add .
    git commit -m $commitMsg 2>&1 | Out-Null
    
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Nothing to commit"
    } else {
        Write-Step "Pushing to remote..."
        git push
        
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to push to remote. Check your git credentials."
        }
        
        Write-Host ""
        Write-Info "✓ Sync complete! Changes pushed to GitHub."
        Write-Host ""
        
        # Show latest commit
        Write-Host "Latest commit:"
        git log -1 --oneline
        Write-Host ""
    }
} finally {
    Pop-Location
}
