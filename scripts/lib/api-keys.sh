#!/bin/bash
# API key management utilities

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Prompt for API key with validation
# Usage: prompt_api_key "Service Name" required|optional
prompt_api_key() {
  local service=$1
  local required=$2
  local key=""
  
  while true; do
    if [ "$required" = "optional" ]; then
      read -p "Enter $service API key (or press Enter to skip): " key
    else
      read -p "Enter $service API key (required): " key
    fi
    
    # If optional and empty, return placeholder
    if [ -z "$key" ] && [ "$required" = "optional" ]; then
      echo "YOUR_${service^^}_API_KEY" | tr ' ' '_' | tr '-' '_'
      return 0
    fi
    
    # If required and empty, show error and loop
    if [ -z "$key" ] && [ "$required" = "required" ]; then
      error "$service API key is required. Please enter a valid key."
    fi
    
    # Key provided, return it
    if [ -n "$key" ]; then
      echo "$key"
      return 0
    fi
  done
}

# Prompt for MCP selection
# Usage: prompt_mcp "MCP Name" "Description"
# Returns: true or false
prompt_mcp() {
  local name=$1
  local desc=$2
  local answer=""
  
  while true; do
    read -p "Enable $name MCP? ($desc) [y/n] (default: n): " answer
    answer=${answer:-n}
    
    case $answer in
      y|Y|yes|Yes|YES)
        echo "true"
        return 0
        ;;
      n|N|no|No|NO)
        echo "false"
        return 0
        ;;
      *)
        warn "Please answer y or n"
        ;;
    esac
  done
}

# Collect MCP selections (all optional)
collect_mcp_selections() {
  step "MCP Server Setup (all optional)..."
  echo ""
  info "MCPs provide extended capabilities like documentation search, web scraping, etc."
  echo ""
  
  # Context7
  ENABLE_CONTEXT7=$(prompt_mcp "Context7" "Documentation search for libraries/frameworks")
  if [ "$ENABLE_CONTEXT7" = "true" ]; then
    info "Context7 MCP enabled"
  else
    warn "Context7 MCP skipped"
  fi
  
  # Firecrawl
  ENABLE_FIRECRAWL=$(prompt_mcp "Firecrawl" "Advanced web scraping and crawling")
  if [ "$ENABLE_FIRECRAWL" = "true" ]; then
    info "Firecrawl MCP enabled"
  else
    warn "Firecrawl MCP skipped"
  fi
  
  # Playwright
  ENABLE_PLAYWRIGHT=$(prompt_mcp "Playwright" "Browser automation and testing")
  if [ "$ENABLE_PLAYWRIGHT" = "true" ]; then
    info "Playwright MCP enabled"
  else
    warn "Playwright MCP skipped"
  fi
  
  # TestSprite
  ENABLE_TESTSPRITE=$(prompt_mcp "TestSprite" "AI-driven test generation")
  if [ "$ENABLE_TESTSPRITE" = "true" ]; then
    info "TestSprite MCP enabled"
  else
    warn "TestSprite MCP skipped"
  fi
  
  # Repomix
  ENABLE_REPOMIX=$(prompt_mcp "Repomix" "Repository packaging for LLM analysis")
  if [ "$ENABLE_REPOMIX" = "true" ]; then
    info "Repomix MCP enabled"
  else
    warn "Repomix MCP skipped"
  fi
  
  # Atlassian
  ENABLE_ATLASSIAN=$(prompt_mcp "Atlassian" "Jira and Confluence integration")
  if [ "$ENABLE_ATLASSIAN" = "true" ]; then
    info "Atlassian MCP enabled"
  else
    warn "Atlassian MCP skipped"
  fi
  
  echo ""
}

# Collect all API keys (all optional now)
collect_api_keys() {
  step "Collecting API keys (press Enter to skip any)..."
  echo ""
  info "All API keys are optional - you can skip any and configure them later"
  echo ""
  
  # OpenRouter
  API_OPENROUTER=$(prompt_api_key "OpenRouter" "optional")
  if [[ "$API_OPENROUTER" != YOUR_* ]]; then
    info "OpenRouter key saved"
  else
    warn "OpenRouter skipped"
  fi
  
  # Groq
  API_GROQ=$(prompt_api_key "Groq" "optional")
  if [[ "$API_GROQ" != YOUR_* ]]; then
    info "Groq key saved"
  else
    warn "Groq skipped"
  fi
  
  # Context7
  API_CONTEXT7=$(prompt_api_key "Context7" "optional")
  if [[ "$API_CONTEXT7" != YOUR_* ]]; then
    info "Context7 key saved"
  else
    warn "Context7 skipped"
  fi
  
  # Firecrawl
  API_FIRECRAWL=$(prompt_api_key "Firecrawl" "optional")
  if [[ "$API_FIRECRAWL" != YOUR_* ]]; then
    info "Firecrawl key saved"
  else
    warn "Firecrawl skipped"
  fi
  
  # TestSprite
  API_TESTSPRITE=$(prompt_api_key "TestSprite" "optional")
  if [[ "$API_TESTSPRITE" != YOUR_* ]]; then
    info "TestSprite key saved"
  else
    warn "TestSprite skipped"
  fi
  
  # OpenAI
  API_OPENAI=$(prompt_api_key "OpenAI" "optional")
  if [[ "$API_OPENAI" != YOUR_* ]]; then
    info "OpenAI key saved"
  else
    warn "OpenAI skipped"
  fi
  
  # Google
  API_GOOGLE=$(prompt_api_key "Google Gemini" "optional")
  if [[ "$API_GOOGLE" != YOUR_* ]]; then
    info "Google key saved"
  else
    warn "Google skipped"
  fi
  
  # Anthropic
  API_ANTHROPIC=$(prompt_api_key "Anthropic" "optional")
  if [[ "$API_ANTHROPIC" != YOUR_* ]]; then
    info "Anthropic key saved"
  else
    warn "Anthropic skipped"
  fi
  
  # Atlassian
  API_ATLASSIAN=$(prompt_api_key "Atlassian" "optional")
  if [[ "$API_ATLASSIAN" != YOUR_* ]]; then
    info "Atlassian key saved"
  else
    warn "Atlassian skipped"
  fi
  
  echo ""
}

# Export API keys as environment variables for replacement
export_api_keys() {
  export API_OPENROUTER
  export API_GROQ
  export API_CONTEXT7
  export API_FIRECRAWL
  export API_TESTSPRITE
  export API_OPENAI
  export API_GOOGLE
  export API_ANTHROPIC
  export API_ATLASSIAN
}

# Export MCP selections
export_mcp_selections() {
  export ENABLE_CONTEXT7
  export ENABLE_FIRECRAWL
  export ENABLE_PLAYWRIGHT
  export ENABLE_TESTSPRITE
  export ENABLE_REPOMIX
  export ENABLE_ATLASSIAN
}

# Disable MCPs in config file based on selections
# Usage: apply_mcp_selections "config_file_path"
apply_mcp_selections() {
  local file=$1
  
  if [ ! -f "$file" ]; then
    warn "File not found: $file"
    return 1
  fi
  
  # Disable MCPs that were not selected
  if [ "$ENABLE_CONTEXT7" = "false" ]; then
    # Change "enabled": true to "enabled": false for context7
    sed -i.bak '/context7/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  if [ "$ENABLE_FIRECRAWL" = "false" ]; then
    sed -i.bak '/firecrawl/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  if [ "$ENABLE_PLAYWRIGHT" = "false" ]; then
    sed -i.bak '/playwright/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  if [ "$ENABLE_TESTSPRITE" = "false" ]; then
    sed -i.bak '/testsprite/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  if [ "$ENABLE_REPOMIX" = "false" ]; then
    sed -i.bak '/repomix/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  if [ "$ENABLE_ATLASSIAN" = "false" ]; then
    sed -i.bak '/atlassian/,/"enabled": true/ s/"enabled": true/"enabled": false/' "$file"
  fi
  
  # Remove backup file
  rm -f "${file}.bak"
}

# Remove disabled MCPs from OpenClaude config
# Usage: apply_mcp_selections_openclaude "config_file_path"
apply_mcp_selections_openclaude() {
  local file=$1
  
  if [ ! -f "$file" ]; then
    warn "File not found: $file"
    return 1
  fi
  
  # Build list of disabled MCPs
  local disabled_mcps=""
  [ "$ENABLE_CONTEXT7" = "false" ] && disabled_mcps="${disabled_mcps}context7,"
  [ "$ENABLE_FIRECRAWL" = "false" ] && disabled_mcps="${disabled_mcps}firecrawl,"
  [ "$ENABLE_PLAYWRIGHT" = "false" ] && disabled_mcps="${disabled_mcps}playwright,"
  [ "$ENABLE_TESTSPRITE" = "false" ] && disabled_mcps="${disabled_mcps}testsprite,"
  [ "$ENABLE_REPOMIX" = "false" ] && disabled_mcps="${disabled_mcps}repomix,"
  [ "$ENABLE_ATLASSIAN" = "false" ] && disabled_mcps="${disabled_mcps}atlassian,"
  
  # Remove trailing comma
  disabled_mcps="${disabled_mcps%,}"
  
  # Use Python script to remove disabled MCPs
  if [ -n "$disabled_mcps" ]; then
    python3 "$SCRIPT_DIR/lib/mcp-filter.py" "$file" "$disabled_mcps"
  fi
}

# Replace API keys in config file
replace_api_keys() {
  local file=$1
  
  if [ ! -f "$file" ]; then
    warn "File not found: $file"
    return 1
  fi
  
  # Replace each placeholder
  replace_in_file "$file" "YOUR_OPENROUTER_API_KEY" "$API_OPENROUTER"
  replace_in_file "$file" "YOUR_GROQ_API_KEY" "$API_GROQ"
  replace_in_file "$file" "YOUR_CONTEXT7_API_KEY" "$API_CONTEXT7"
  replace_in_file "$file" "YOUR_FIRECRAWL_API_KEY" "$API_FIRECRAWL"
  replace_in_file "$file" "YOUR_TESTSPRITE_API_KEY" "$API_TESTSPRITE"
  replace_in_file "$file" "YOUR_OPENAI_API_KEY" "$API_OPENAI"
  replace_in_file "$file" "YOUR_GOOGLE_API_KEY" "$API_GOOGLE"
  replace_in_file "$file" "YOUR_ANTHROPIC_API_KEY" "$API_ANTHROPIC"
  replace_in_file "$file" "YOUR_ATLASSIAN_AUTH_TOKEN" "$API_ATLASSIAN"
}

# Show API keys summary (masked)
show_keys_summary() {
  echo ""
  step "API Keys Summary:"
  echo ""
  
  show_key_status "OpenRouter" "$API_OPENROUTER"
  show_key_status "Groq" "$API_GROQ"
  show_key_status "Context7" "$API_CONTEXT7"
  show_key_status "Firecrawl" "$API_FIRECRAWL"
  show_key_status "TestSprite" "$API_TESTSPRITE"
  show_key_status "OpenAI" "$API_OPENAI"
  show_key_status "Google" "$API_GOOGLE"
  show_key_status "Anthropic" "$API_ANTHROPIC"
  show_key_status "Atlassian" "$API_ATLASSIAN"
  
  echo ""
}

# Show status of a single key (masked)
show_key_status() {
  local name=$1
  local key=$2
  
  if [[ "$key" == YOUR_* ]] || [ -z "$key" ]; then
    echo "  $name: $(tput setaf 3)Skipped$(tput sgr0)"
  else
    local masked="${key:0:8}...${key: -4}"
    echo "  $name: $(tput setaf 2)Set$(tput sgr0) ($masked)"
  fi
}
