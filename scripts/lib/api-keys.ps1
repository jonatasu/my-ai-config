# API key management utilities for PowerShell

# Import common functions
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# Prompt for API key
function Read-ApiKey {
    param(
        [string]$ServiceName,
        [bool]$Optional = $true
    )
    
    while ($true) {
        if ($Optional) {
            $key = Read-Host "Enter $ServiceName API key (or press Enter to skip)"
        } else {
            $key = Read-Host "Enter $ServiceName API key (required)"
        }
        
        # If optional and empty, return placeholder
        if ([string]::IsNullOrWhiteSpace($key) -and $Optional) {
            $placeholder = "YOUR_$($ServiceName.ToUpper().Replace(' ', '_').Replace('-', '_'))_API_KEY"
            return $placeholder
        }
        
        # If required and empty, show error and loop
        if ([string]::IsNullOrWhiteSpace($key) -and -not $Optional) {
            Write-Warning "$ServiceName API key is required. Please enter a valid key."
            continue
        }
        
        # Key provided, return it
        if (-not [string]::IsNullOrWhiteSpace($key)) {
            return $key
        }
    }
}

# Prompt for MCP selection
function Read-McpSelection {
    param(
        [string]$Name,
        [string]$Description
    )
    
    while ($true) {
        $answer = Read-Host "Enable $Name MCP? ($Description) [y/n] (default: n)"
        if ([string]::IsNullOrWhiteSpace($answer)) { $answer = "n" }
        
        switch ($answer.ToLower()) {
            { $_ -in @('y', 'yes') } {
                return $true
            }
            { $_ -in @('n', 'no') } {
                return $false
            }
            default {
                Write-Warning "Please answer y or n"
            }
        }
    }
}

# Collect all MCP selections
function Get-McpSelections {
    Write-Step "MCP Server Setup (all optional)..."
    Write-Host ""
    Write-Info "MCPs provide extended capabilities like documentation search, web scraping, etc."
    Write-Host ""
    
    $selections = @{}
    
    # Context7
    $selections['context7'] = Read-McpSelection -Name "Context7" -Description "Documentation search for libraries/frameworks"
    if ($selections['context7']) {
        Write-Info "Context7 MCP enabled"
    } else {
        Write-Warning "Context7 MCP skipped"
    }
    
    # Firecrawl
    $selections['firecrawl'] = Read-McpSelection -Name "Firecrawl" -Description "Advanced web scraping and crawling"
    if ($selections['firecrawl']) {
        Write-Info "Firecrawl MCP enabled"
    } else {
        Write-Warning "Firecrawl MCP skipped"
    }
    
    # Playwright
    $selections['playwright'] = Read-McpSelection -Name "Playwright" -Description "Browser automation and testing"
    if ($selections['playwright']) {
        Write-Info "Playwright MCP enabled"
    } else {
        Write-Warning "Playwright MCP skipped"
    }
    
    # TestSprite
    $selections['testsprite'] = Read-McpSelection -Name "TestSprite" -Description "AI-driven test generation"
    if ($selections['testsprite']) {
        Write-Info "TestSprite MCP enabled"
    } else {
        Write-Warning "TestSprite MCP skipped"
    }
    
    # Repomix
    $selections['repomix'] = Read-McpSelection -Name "Repomix" -Description "Repository packaging for LLM analysis"
    if ($selections['repomix']) {
        Write-Info "Repomix MCP enabled"
    } else {
        Write-Warning "Repomix MCP skipped"
    }
    
    # Atlassian
    $selections['atlassian'] = Read-McpSelection -Name "Atlassian" -Description "Jira and Confluence integration"
    if ($selections['atlassian']) {
        Write-Info "Atlassian MCP enabled"
    } else {
        Write-Warning "Atlassian MCP skipped"
    }
    
    Write-Host ""
    return $selections
}

# Collect all API keys
function Get-ApiKeys {
    Write-Step "Collecting API keys (press Enter to skip any)..."
    Write-Host ""
    Write-Info "All API keys are optional - you can skip any and configure them later"
    Write-Host ""
    
    $keys = @{}
    
    # OpenRouter
    $keys['openrouter'] = Read-ApiKey -ServiceName "OpenRouter" -Optional $true
    if ($keys['openrouter'] -notmatch '^YOUR_') {
        Write-Info "OpenRouter key saved"
    } else {
        Write-Warning "OpenRouter skipped"
    }
    
    # Groq
    $keys['groq'] = Read-ApiKey -ServiceName "Groq" -Optional $true
    if ($keys['groq'] -notmatch '^YOUR_') {
        Write-Info "Groq key saved"
    } else {
        Write-Warning "Groq skipped"
    }
    
    # Context7
    $keys['context7'] = Read-ApiKey -ServiceName "Context7" -Optional $true
    if ($keys['context7'] -notmatch '^YOUR_') {
        Write-Info "Context7 key saved"
    } else {
        Write-Warning "Context7 skipped"
    }
    
    # Firecrawl
    $keys['firecrawl'] = Read-ApiKey -ServiceName "Firecrawl" -Optional $true
    if ($keys['firecrawl'] -notmatch '^YOUR_') {
        Write-Info "Firecrawl key saved"
    } else {
        Write-Warning "Firecrawl skipped"
    }
    
    # TestSprite
    $keys['testsprite'] = Read-ApiKey -ServiceName "TestSprite" -Optional $true
    if ($keys['testsprite'] -notmatch '^YOUR_') {
        Write-Info "TestSprite key saved"
    } else {
        Write-Warning "TestSprite skipped"
    }
    
    # OpenAI
    $keys['openai'] = Read-ApiKey -ServiceName "OpenAI" -Optional $true
    if ($keys['openai'] -notmatch '^YOUR_') {
        Write-Info "OpenAI key saved"
    } else {
        Write-Warning "OpenAI skipped"
    }
    
    # Google
    $keys['google'] = Read-ApiKey -ServiceName "Google Gemini" -Optional $true
    if ($keys['google'] -notmatch '^YOUR_') {
        Write-Info "Google key saved"
    } else {
        Write-Warning "Google skipped"
    }
    
    # Anthropic
    $keys['anthropic'] = Read-ApiKey -ServiceName "Anthropic" -Optional $true
    if ($keys['anthropic'] -notmatch '^YOUR_') {
        Write-Info "Anthropic key saved"
    } else {
        Write-Warning "Anthropic skipped"
    }
    
    # Atlassian
    $keys['atlassian'] = Read-ApiKey -ServiceName "Atlassian" -Optional $true
    if ($keys['atlassian'] -notmatch '^YOUR_') {
        Write-Info "Atlassian key saved"
    } else {
        Write-Warning "Atlassian skipped"
    }
    
    Write-Host ""
    return $keys
}

# Show API keys summary
function Show-KeysSummary {
    param([hashtable]$ApiKeys)
    
    Write-Host ""
    Write-Step "API Keys Summary:"
    Write-Host ""
    
    foreach ($service in @('openrouter', 'groq', 'context7', 'firecrawl', 'testsprite', 'openai', 'google', 'anthropic', 'atlassian')) {
        $displayName = $service.Substring(0,1).ToUpper() + $service.Substring(1)
        $key = $ApiKeys[$service]
        
        if ([string]::IsNullOrWhiteSpace($key) -or $key -match '^YOUR_') {
            Write-Host "  $displayName`: " -NoNewline
            Write-Host "Skipped" -ForegroundColor Yellow
        } else {
            $masked = Get-MaskedKey -Key $key
            Write-Host "  $displayName`: " -NoNewline
            Write-Host "Set" -ForegroundColor Green -NoNewline
            Write-Host " ($masked)"
        }
    }
    
    Write-Host ""
}

# Replace API keys in config file
function Set-ApiKeysInFile {
    param(
        [string]$FilePath,
        [hashtable]$ApiKeys
    )
    
    if (-not (Test-Path -Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return
    }
    
    Replace-InFile -FilePath $FilePath -Find "YOUR_OPENROUTER_API_KEY" -Replace $ApiKeys['openrouter']
    Replace-InFile -FilePath $FilePath -Find "YOUR_GROQ_API_KEY" -Replace $ApiKeys['groq']
    Replace-InFile -FilePath $FilePath -Find "YOUR_CONTEXT7_API_KEY" -Replace $ApiKeys['context7']
    Replace-InFile -FilePath $FilePath -Find "YOUR_FIRECRAWL_API_KEY" -Replace $ApiKeys['firecrawl']
    Replace-InFile -FilePath $FilePath -Find "YOUR_TESTSPRITE_API_KEY" -Replace $ApiKeys['testsprite']
    Replace-InFile -FilePath $FilePath -Find "YOUR_OPENAI_API_KEY" -Replace $ApiKeys['openai']
    Replace-InFile -FilePath $FilePath -Find "YOUR_GOOGLE_API_KEY" -Replace $ApiKeys['google']
    Replace-InFile -FilePath $FilePath -Find "YOUR_ANTHROPIC_API_KEY" -Replace $ApiKeys['anthropic']
    Replace-InFile -FilePath $FilePath -Find "YOUR_ATLASSIAN_AUTH_TOKEN" -Replace $ApiKeys['atlassian']
}

# Apply MCP selections to OpenCode config file
function Set-McpSelectionsInFile {
    param(
        [string]$FilePath,
        [hashtable]$McpSelections
    )
    
    if (-not (Test-Path -Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return
    }
    
    $content = Get-Content -Path $FilePath -Raw
    
    # Disable MCPs that were not selected
    foreach ($mcp in $McpSelections.Keys) {
        if (-not $McpSelections[$mcp]) {
            # Use regex to find the MCP section and change enabled to false
            $pattern = "(`"$mcp`"[^}]*?`"enabled`":\s*)true"
            $content = $content -replace $pattern, '$1false'
        }
    }
    
    Set-Content -Path $FilePath -Value $content -NoNewline
}

# Apply MCP selections to OpenClaude config file (remove disabled MCPs)
function Set-McpSelectionsInFileOpenClaude {
    param(
        [string]$FilePath,
        [hashtable]$McpSelections
    )
    
    if (-not (Test-Path -Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return
    }
    
    # Build list of disabled MCPs
    $disabledMcps = @()
    foreach ($mcp in $McpSelections.Keys) {
        if (-not $McpSelections[$mcp]) {
            $disabledMcps += $mcp
        }
    }
    
    # Use Python script to remove disabled MCPs
    if ($disabledMcps.Count -gt 0) {
        $mcpList = $disabledMcps -join ','
        $pythonScript = Join-Path (Split-Path -Parent $FilePath) "..\..\..\scripts\lib\mcp-filter.py"
        if (-not (Test-Path $pythonScript)) {
            $pythonScript = Join-Path $ScriptDir "mcp-filter.py"
        }
        
        if (Test-Path $pythonScript) {
            & python $pythonScript $FilePath $mcpList
        } else {
            Write-Warning "mcp-filter.py not found, skipping MCP removal for OpenClaude"
        }
    }
}
