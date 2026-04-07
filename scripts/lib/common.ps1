# Common utilities for PowerShell installer scripts

# Output functions with colors
function Write-Info {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "! $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
    throw $Message
}

function Write-Step {
    param([string]$Message)
    Write-Host "→ $Message" -ForegroundColor Blue
}

# Get operating system
function Get-OperatingSystem {
    if ($IsWindows -or $env:OS -match "Windows") {
        return "windows"
    } elseif ($IsMacOS) {
        Write-Error "macOS detected. Please use install.sh instead."
    } elseif ($IsLinux) {
        Write-Error "Linux detected. Please use install.sh instead."
    } else {
        Write-Error "Unsupported OS"
    }
}

# Test if command exists
function Test-CommandExists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Require a command to be installed
function Test-Command {
    param(
        [string]$Command,
        [string]$InstallMessage = "Please install $Command"
    )
    
    if (-not (Test-CommandExists $Command)) {
        Write-Error "$Command not found. $InstallMessage"
    }
}

# Create directory if it doesn't exist
function New-DirectoryIfNotExists {
    param([string]$Path)
    
    if (-not (Test-Path -Path $Path)) {
        try {
            New-Item -Path $Path -ItemType Directory -Force | Out-Null
        } catch {
            Write-Error "Failed to create directory: $Path"
        }
    }
}

# Backup file if it exists
function Backup-File {
    param(
        [string]$FilePath,
        [string]$BackupDir
    )
    
    if (Test-Path -Path $FilePath) {
        New-DirectoryIfNotExists -Path $BackupDir
        try {
            $FileName = Split-Path -Leaf $FilePath
            Copy-Item -Path $FilePath -Destination (Join-Path $BackupDir $FileName) -Force
        } catch {
            Write-Warning "Failed to backup: $FilePath"
        }
    }
}

# Backup directory if it exists
function Backup-Directory {
    param(
        [string]$DirPath,
        [string]$BackupDir
    )
    
    if (Test-Path -Path $DirPath) {
        New-DirectoryIfNotExists -Path $BackupDir
        try {
            $DirName = Split-Path -Leaf $DirPath
            $DestPath = Join-Path $BackupDir $DirName
            if (Test-Path -Path $DestPath) {
                Remove-Item -Path $DestPath -Recurse -Force
            }
            Copy-Item -Path $DirPath -Destination $DestPath -Recurse -Force
        } catch {
            Write-Warning "Failed to backup: $DirPath"
        }
    }
}

# Replace text in file
function Replace-InFile {
    param(
        [string]$FilePath,
        [string]$Find,
        [string]$Replace
    )
    
    if (Test-Path -Path $FilePath) {
        try {
            $content = Get-Content -Path $FilePath -Raw
            $content = $content -replace [regex]::Escape($Find), $Replace
            Set-Content -Path $FilePath -Value $content -NoNewline
        } catch {
            Write-Warning "Failed to replace text in: $FilePath"
        }
    } else {
        Write-Warning "File not found: $FilePath"
    }
}

# Check if Ollama is installed
function Test-Ollama {
    if (Test-CommandExists "ollama") {
        return "detected"
    } else {
        return "not_installed"
    }
}

# Get Ollama models
function Get-OllamaModels {
    if (-not (Test-CommandExists "ollama")) {
        return @()
    }
    
    try {
        $output = & ollama list 2>$null
        if ($LASTEXITCODE -ne 0) {
            return @()
        }
        
        # Parse output, skip header, get first column
        $models = $output | Select-Object -Skip 1 | ForEach-Object {
            if ($_ -match '^(\S+)') {
                $matches[1]
            }
        } | Where-Object { $_ }
        
        return $models
    } catch {
        return @()
    }
}

# Validate JSON file
function Test-JsonFile {
    param([string]$FilePath)
    
    if (-not (Test-Path -Path $FilePath)) {
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

# Sanitize API key for display (show first 8 and last 4 chars)
function Get-MaskedKey {
    param([string]$Key)
    
    if ([string]::IsNullOrWhiteSpace($Key) -or $Key -match '^YOUR_') {
        return $null
    }
    
    if ($Key.Length -le 12) {
        return "$($Key.Substring(0, [Math]::Min(4, $Key.Length)))..."
    }
    
    return "$($Key.Substring(0, 8))...$($Key.Substring($Key.Length - 4))"
}
