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

# Collect all required API keys
collect_required_keys() {
  step "Collecting required API keys..."
  echo ""
  
  # OpenRouter (required)
  API_OPENROUTER=$(prompt_api_key "OpenRouter" "required")
  info "OpenRouter key saved"
  
  # Groq (required)
  API_GROQ=$(prompt_api_key "Groq" "required")
  info "Groq key saved"
  
  echo ""
}

# Collect optional API keys
collect_optional_keys() {
  step "Collecting optional API keys (press Enter to skip any)..."
  echo ""
  
  # Context7
  API_CONTEXT7=$(prompt_api_key "Context7" "optional")
  if [[ "$API_CONTEXT7" != YOUR_* ]]; then
    info "Context7 key saved"
  else
    warn "Context7 skipped (can add later)"
  fi
  
  # Firecrawl
  API_FIRECRAWL=$(prompt_api_key "Firecrawl" "optional")
  if [[ "$API_FIRECRAWL" != YOUR_* ]]; then
    info "Firecrawl key saved"
  else
    warn "Firecrawl skipped (can add later)"
  fi
  
  # TestSprite
  API_TESTSPRITE=$(prompt_api_key "TestSprite" "optional")
  if [[ "$API_TESTSPRITE" != YOUR_* ]]; then
    info "TestSprite key saved"
  else
    warn "TestSprite skipped (can add later)"
  fi
  
  # OpenAI
  API_OPENAI=$(prompt_api_key "OpenAI" "optional")
  if [[ "$API_OPENAI" != YOUR_* ]]; then
    info "OpenAI key saved"
  else
    warn "OpenAI skipped (can add later)"
  fi
  
  # Google
  API_GOOGLE=$(prompt_api_key "Google Gemini" "optional")
  if [[ "$API_GOOGLE" != YOUR_* ]]; then
    info "Google key saved"
  else
    warn "Google skipped (can add later)"
  fi
  
  # Anthropic
  API_ANTHROPIC=$(prompt_api_key "Anthropic" "optional")
  if [[ "$API_ANTHROPIC" != YOUR_* ]]; then
    info "Anthropic key saved"
  else
    warn "Anthropic skipped (can add later)"
  fi
  
  # Atlassian
  API_ATLASSIAN=$(prompt_api_key "Atlassian" "optional")
  if [[ "$API_ATLASSIAN" != YOUR_* ]]; then
    info "Atlassian key saved"
  else
    warn "Atlassian skipped (can add later)"
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
