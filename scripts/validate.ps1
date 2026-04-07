# Validate installed configurations

# Stop on errors
$ErrorActionPreference = "Stop"

# Import common functions
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\common.ps1"

$Errors = 0
$Warnings = 0

Write-Host ""
Write-Step "Validating installation..."
Write-Host ""

# Validate OpenCode if installed
function Test-OpenCodeInstallation {
    $ConfigDir = Join-Path $env:USERPROFILE ".config\opencode"
    $ConfigFile = Join-Path $ConfigDir "opencode.json"
    $SkillsDir = Join-Path $ConfigDir "skills"
    
    if (-not (Test-Path -Path $ConfigDir)) {
        return  # Not installed, skip validation
    }
    
    Write-Step "Validating OpenCode..."
    
    # Check config file exists
    if (-not (Test-Path -Path $ConfigFile)) {
        Write-Error "OpenCode config missing: $ConfigFile"
        $script:Errors++
    } else {
        Write-Info "Config file found"
        
        # Validate JSON syntax
        if (Test-JsonFile -FilePath $ConfigFile) {
            Write-Info "JSON syntax valid"
        } else {
            Write-Error "Invalid JSON syntax in $ConfigFile"
            $script:Errors++
        }
        
        # Check for placeholder API keys
        $content = Get-Content -Path $ConfigFile -Raw
        if ($content -match "YOUR_.*_API_KEY") {
            Write-Warning "Some API keys still use placeholders (can add later)"
            $script:Warnings++
        } else {
            Write-Info "No placeholder API keys found"
        }
    }
    
    # Check skills directory
    if (-not (Test-Path -Path $SkillsDir)) {
        Write-Error "OpenCode skills directory missing"
        $script:Errors++
    } else {
        $skillCount = (Get-ChildItem -Path $SkillsDir -ErrorAction SilentlyContinue).Count
        if ($skillCount -eq 0) {
            Write-Error "No skills found in $SkillsDir"
            $script:Errors++
        } else {
            Write-Info "Found $skillCount skills"
        }
    }
    
    Write-Host ""
}

# Validate OpenClaude if installed
function Test-OpenClaudeInstallation {
    $ClaudeJson = Join-Path $env:USERPROFILE ".claude.json"
    $ProfileJson = Join-Path $env:USERPROFILE ".openclaude-profile.json"
    $ConfigDir = Join-Path $env:USERPROFILE ".config\openclaude"
    $ConfigFile = Join-Path $ConfigDir "openclaude.json"
    $SkillsDir = Join-Path $ConfigDir "skills"
    
    $hasAnyFile = (Test-Path -Path $ClaudeJson) -or (Test-Path -Path $ProfileJson) -or (Test-Path -Path $ConfigDir)
    if (-not $hasAnyFile) {
        return  # Not installed, skip validation
    }
    
    Write-Step "Validating OpenClaude..."
    
    # Check main config
    if (-not (Test-Path -Path $ClaudeJson)) {
        Write-Error "OpenClaude main config missing: $ClaudeJson"
        $script:Errors++
    } else {
        Write-Info "Main config found"
        
        if (Test-JsonFile -FilePath $ClaudeJson) {
            Write-Info "Main config JSON valid"
        } else {
            Write-Error "Invalid JSON in $ClaudeJson"
            $script:Errors++
        }
        
        # Check for placeholder API keys
        $content = Get-Content -Path $ClaudeJson -Raw
        if ($content -match "YOUR_.*_API_KEY") {
            Write-Warning "Some API keys in .claude.json use placeholders"
            $script:Warnings++
        }
    }
    
    # Check profile
    if (-not (Test-Path -Path $ProfileJson)) {
        Write-Error "OpenClaude profile missing: $ProfileJson"
        $script:Errors++
    } else {
        Write-Info "Profile found"
        
        if (Test-JsonFile -FilePath $ProfileJson) {
            Write-Info "Profile JSON valid"
        } else {
            Write-Error "Invalid JSON in $ProfileJson"
            $script:Errors++
        }
    }
    
    # Check config directory
    if (-not (Test-Path -Path $ConfigFile)) {
        Write-Error "OpenClaude config file missing: $ConfigFile"
        $script:Errors++
    } else {
        Write-Info "Config file found"
        
        if (Test-JsonFile -FilePath $ConfigFile) {
            Write-Info "Config JSON valid"
        } else {
            Write-Error "Invalid JSON in $ConfigFile"
            $script:Errors++
        }
    }
    
    # Check skills directory
    if (-not (Test-Path -Path $SkillsDir)) {
        Write-Error "OpenClaude skills directory missing"
        $script:Errors++
    } else {
        $skillCount = (Get-ChildItem -Path $SkillsDir -ErrorAction SilentlyContinue).Count
        if ($skillCount -eq 0) {
            Write-Error "No skills found in $SkillsDir"
            $script:Errors++
        } else {
            Write-Info "Found $skillCount skills"
        }
    }
    
    Write-Host ""
}

# Run validations
Test-OpenCodeInstallation
Test-OpenClaudeInstallation

# Summary
if ($Errors -eq 0 -and $Warnings -eq 0) {
    Write-Info "✓ All checks passed!"
    Write-Host ""
    exit 0
} elseif ($Errors -eq 0) {
    Write-Warning "Validation complete with $Warnings warning(s)"
    Write-Host ""
    exit 0
} else {
    Write-Error "Validation failed with $Errors error(s) and $Warnings warning(s)"
    Write-Host ""
    exit 1
}
