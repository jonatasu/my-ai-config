# Backup existing configurations before installation

# Stop on errors
$ErrorActionPreference = "Stop"

# Import common functions
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\common.ps1"

# Backup directory with timestamp
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupDir = Join-Path $env:USERPROFILE ".ai-config-backups\$Timestamp"

Write-Host ""
Write-Step "Creating backup of existing configurations..."

# Create backup directory
New-DirectoryIfNotExists -Path $BackupDir

# Track if anything was backed up
$BackedUp = $false

# Backup OpenCode
$OpenCodeDir = Join-Path $env:USERPROFILE ".config\opencode"
if (Test-Path -Path $OpenCodeDir) {
    Write-Info "Backing up OpenCode config..."
    Backup-Directory -DirPath $OpenCodeDir -BackupDir $BackupDir
    $BackedUp = $true
}

# Backup OpenClaude
$ClaudeJson = Join-Path $env:USERPROFILE ".claude.json"
if (Test-Path -Path $ClaudeJson) {
    Write-Info "Backing up OpenClaude main config..."
    Backup-File -FilePath $ClaudeJson -BackupDir $BackupDir
    $BackedUp = $true
}

$ProfileJson = Join-Path $env:USERPROFILE ".openclaude-profile.json"
if (Test-Path -Path $ProfileJson) {
    Write-Info "Backing up OpenClaude profile..."
    Backup-File -FilePath $ProfileJson -BackupDir $BackupDir
    $BackedUp = $true
}

$OpenClaudeDir = Join-Path $env:USERPROFILE ".config\openclaude"
if (Test-Path -Path $OpenClaudeDir) {
    Write-Info "Backing up OpenClaude config directory..."
    Backup-Directory -DirPath $OpenClaudeDir -BackupDir $BackupDir
    $BackedUp = $true
}

if ($BackedUp) {
    Write-Info "Backup created at: $BackupDir"
    Write-Host ""
} else {
    Write-Warning "No existing configurations found to backup"
    # Remove empty backup directory
    try {
        Remove-Item -Path $BackupDir -Force -ErrorAction SilentlyContinue
        $BackupsRoot = Join-Path $env:USERPROFILE ".ai-config-backups"
        if ((Get-ChildItem -Path $BackupsRoot -ErrorAction SilentlyContinue).Count -eq 0) {
            Remove-Item -Path $BackupsRoot -Force -ErrorAction SilentlyContinue
        }
    } catch {}
    Write-Host ""
}
