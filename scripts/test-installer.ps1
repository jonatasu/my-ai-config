# Test installer in a clean environment
# This script simulates a fresh installation without actually modifying the system

# Stop on errors
$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = Split-Path -Parent $ScriptDir

Write-Host ""
Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Installer Test - Dry Run Mode      ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Test counters
$TestsPassed = 0
$TestsFailed = 0

# Test function
function Test-Condition {
    param(
        [string]$TestName,
        [bool]$Condition
    )
    
    if ($Condition) {
        Write-Host "✓ $TestName" -ForegroundColor Green
        $script:TestsPassed++
    } else {
        Write-Host "✗ $TestName" -ForegroundColor Red
        $script:TestsFailed++
    }
}

# Test prerequisites
Write-Host "→ Testing prerequisites..." -ForegroundColor Blue
Write-Host ""

Test-Condition "Git installed" ($null -ne (Get-Command git -ErrorAction SilentlyContinue))
Test-Condition "Node.js installed" ($null -ne (Get-Command node -ErrorAction SilentlyContinue))
Test-Condition "Python installed" ($null -ne (Get-Command python -ErrorAction SilentlyContinue))

Write-Host ""

# Test repository structure
Write-Host "→ Testing repository structure..." -ForegroundColor Blue
Write-Host ""

Test-Condition "install.sh exists" (Test-Path (Join-Path $RepoDir "install.sh"))
Test-Condition "install.ps1 exists" (Test-Path (Join-Path $RepoDir "install.ps1"))
Test-Condition "sync.sh exists" (Test-Path (Join-Path $RepoDir "sync.sh"))
Test-Condition "sync.ps1 exists" (Test-Path (Join-Path $RepoDir "sync.ps1"))
Test-Condition "configs/ directory exists" (Test-Path (Join-Path $RepoDir "configs"))
Test-Condition "scripts/ directory exists" (Test-Path (Join-Path $RepoDir "scripts"))
Test-Condition "docs/ directory exists" (Test-Path (Join-Path $RepoDir "docs"))

Write-Host ""

# Test config templates
Write-Host "→ Testing config templates..." -ForegroundColor Blue
Write-Host ""

Test-Condition "OpenCode template exists" (Test-Path (Join-Path $RepoDir "configs\opencode\opencode.json.template"))
Test-Condition "OpenClaude .claude.json template exists" (Test-Path (Join-Path $RepoDir "configs\openclaude\.claude.json.template"))
Test-Condition "OpenClaude profile template exists" (Test-Path (Join-Path $RepoDir "configs\openclaude\.openclaude-profile.json.template"))
Test-Condition "OpenClaude commands template exists" (Test-Path (Join-Path $RepoDir "configs\openclaude\openclaude.json.template"))

Write-Host ""

# Test skills
Write-Host "→ Testing skills..." -ForegroundColor Blue
Write-Host ""

$SkillsDir = Join-Path $RepoDir "configs\skills"
$SkillCount = 0

if (Test-Path $SkillsDir) {
    $SkillCount = (Get-ChildItem -Path $SkillsDir -ErrorAction SilentlyContinue).Count
}

Test-Condition "Skills directory exists" (Test-Path $SkillsDir)
Test-Condition "Skills count >= 50" ($SkillCount -ge 50)
Write-Host "  Found $SkillCount skills"

Write-Host ""

# Test helper scripts
Write-Host "→ Testing helper scripts..." -ForegroundColor Blue
Write-Host ""

Test-Condition "scripts/lib/common.sh exists" (Test-Path (Join-Path $RepoDir "scripts\lib\common.sh"))
Test-Condition "scripts/lib/common.ps1 exists" (Test-Path (Join-Path $RepoDir "scripts\lib\common.ps1"))
Test-Condition "scripts/lib/api-keys.sh exists" (Test-Path (Join-Path $RepoDir "scripts\lib\api-keys.sh"))
Test-Condition "scripts/lib/api-keys.ps1 exists" (Test-Path (Join-Path $RepoDir "scripts\lib\api-keys.ps1"))
Test-Condition "scripts/lib/mcp-filter.py exists" (Test-Path (Join-Path $RepoDir "scripts\lib\mcp-filter.py"))
Test-Condition "scripts/backup.sh exists" (Test-Path (Join-Path $RepoDir "scripts\backup.sh"))
Test-Condition "scripts/backup.ps1 exists" (Test-Path (Join-Path $RepoDir "scripts\backup.ps1"))
Test-Condition "scripts/validate.sh exists" (Test-Path (Join-Path $RepoDir "scripts\validate.sh"))
Test-Condition "scripts/validate.ps1 exists" (Test-Path (Join-Path $RepoDir "scripts\validate.ps1"))

Write-Host ""

# Test documentation
Write-Host "→ Testing documentation..." -ForegroundColor Blue
Write-Host ""

Test-Condition "README.md exists" (Test-Path (Join-Path $RepoDir "README.md"))
Test-Condition "API_KEYS.md exists" (Test-Path (Join-Path $RepoDir "docs\API_KEYS.md"))
Test-Condition "WINDOWS_SETUP.md exists" (Test-Path (Join-Path $RepoDir "docs\WINDOWS_SETUP.md"))
Test-Condition "TOOLS_COMPARISON.md exists" (Test-Path (Join-Path $RepoDir "docs\TOOLS_COMPARISON.md"))
Test-Condition "MIGRATION.md exists" (Test-Path (Join-Path $RepoDir "docs\MIGRATION.md"))

Write-Host ""

# Test JSON validity
Write-Host "→ Testing JSON validity..." -ForegroundColor Blue
Write-Host ""

function Test-JsonFile {
    param([string]$FilePath)
    
    if (-not (Test-Path $FilePath)) {
        return $false
    }
    
    try {
        $content = Get-Content -Path $FilePath -Raw
        $null = ConvertFrom-Json $content
        return $true
    } catch {
        return $false
    }
}

Test-Condition "OpenCode template is valid JSON" (Test-JsonFile (Join-Path $RepoDir "configs\opencode\opencode.json.template"))
Test-Condition "OpenClaude .claude.json is valid JSON" (Test-JsonFile (Join-Path $RepoDir "configs\openclaude\.claude.json.template"))
Test-Condition "OpenClaude profile is valid JSON" (Test-JsonFile (Join-Path $RepoDir "configs\openclaude\.openclaude-profile.json.template"))
Test-Condition "OpenClaude commands is valid JSON" (Test-JsonFile (Join-Path $RepoDir "configs\openclaude\openclaude.json.template"))

Write-Host ""

# Test placeholders
Write-Host "→ Testing API key placeholders..." -ForegroundColor Blue
Write-Host ""

function Test-HasPlaceholders {
    param([string]$FilePath)
    
    if (-not (Test-Path $FilePath)) {
        return $false
    }
    
    $content = Get-Content -Path $FilePath -Raw
    return $content -match "YOUR_.*_API_KEY"
}

Test-Condition "OpenCode has placeholders" (Test-HasPlaceholders (Join-Path $RepoDir "configs\opencode\opencode.json.template"))
Test-Condition "OpenClaude .claude.json has placeholders" (Test-HasPlaceholders (Join-Path $RepoDir "configs\openclaude\.claude.json.template"))

Write-Host ""

# Test no secrets committed
Write-Host "→ Testing for committed secrets..." -ForegroundColor Blue
Write-Host ""

function Test-NoSecrets {
    param([string]$FilePath)
    
    if (-not (Test-Path $FilePath)) {
        return $true
    }
    
    $content = Get-Content -Path $FilePath -Raw
    # Check for common API key patterns that shouldn't be in templates
    $hasSecrets = $content -match "(sk-[a-zA-Z0-9]{20,}|gsk_[a-zA-Z0-9]{20,}|fc-[a-zA-Z0-9]{20,}|ctx7sk-[a-zA-Z0-9]{20,}|AIza[a-zA-Z0-9]{20,})"
    return -not $hasSecrets
}

Test-Condition "OpenCode template has no real keys" (Test-NoSecrets (Join-Path $RepoDir "configs\opencode\opencode.json.template"))
Test-Condition "OpenClaude template has no real keys" (Test-NoSecrets (Join-Path $RepoDir "configs\openclaude\.claude.json.template"))

Write-Host ""

# Summary
Write-Host "╔═══════════════════════════════════════╗" -ForegroundColor Cyan
if ($TestsFailed -eq 0) {
    Write-Host "║  ✓ All Tests Passed!                 ║" -ForegroundColor Green
} else {
    Write-Host "║  ✗ Some Tests Failed                 ║" -ForegroundColor Red
}
Write-Host "╚═══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Results:"
Write-Host "  Passed: $TestsPassed" -ForegroundColor Green
if ($TestsFailed -gt 0) {
    Write-Host "  Failed: $TestsFailed" -ForegroundColor Red
}
Write-Host ""

if ($TestsFailed -gt 0) {
    exit 1
}

exit 0
