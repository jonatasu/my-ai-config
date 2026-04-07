#!/bin/bash
# Validate installed configurations

set -e

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

ERRORS=0
WARNINGS=0

echo ""
step "Validating installation..."
echo ""

# Validate OpenCode if installed
validate_opencode() {
  local config_dir="$HOME/.config/opencode"
  local config_file="$config_dir/opencode.json"
  local skills_dir="$config_dir/skills"
  
  if [ ! -d "$config_dir" ]; then
    return 0  # Not installed, skip validation
  fi
  
  step "Validating OpenCode..."
  
  # Check config file exists
  if [ ! -f "$config_file" ]; then
    error "OpenCode config missing: $config_file"
    ((ERRORS++))
  else
    info "Config file found"
    
    # Validate JSON syntax
    if validate_json "$config_file"; then
      info "JSON syntax valid"
    else
      error "Invalid JSON syntax in $config_file"
      ((ERRORS++))
    fi
    
    # Check for placeholder API keys
    if grep -q "YOUR_.*_API_KEY" "$config_file" 2>/dev/null; then
      warn "Some API keys still use placeholders (can add later)"
      ((WARNINGS++))
    else
      info "No placeholder API keys found"
    fi
  fi
  
  # Check skills directory
  if [ ! -d "$skills_dir" ]; then
    error "OpenCode skills directory missing"
    ((ERRORS++))
  else
    local skill_count=$(ls -1 "$skills_dir" | wc -l | tr -d ' ')
    if [ "$skill_count" -eq 0 ]; then
      error "No skills found in $skills_dir"
      ((ERRORS++))
    else
      info "Found $skill_count skills"
    fi
  fi
  
  echo ""
}

# Validate OpenClaude if installed
validate_openclaude() {
  local claude_json="$HOME/.claude.json"
  local profile_json="$HOME/.openclaude-profile.json"
  local config_dir="$HOME/.config/openclaude"
  local config_file="$config_dir/openclaude.json"
  local skills_dir="$config_dir/skills"
  
  if [ ! -f "$claude_json" ] && [ ! -f "$profile_json" ] && [ ! -d "$config_dir" ]; then
    return 0  # Not installed, skip validation
  fi
  
  step "Validating OpenClaude..."
  
  # Check main config
  if [ ! -f "$claude_json" ]; then
    error "OpenClaude main config missing: $claude_json"
    ((ERRORS++))
  else
    info "Main config found"
    
    if validate_json "$claude_json"; then
      info "Main config JSON valid"
    else
      error "Invalid JSON in $claude_json"
      ((ERRORS++))
    fi
    
    # Check for placeholder API keys
    if grep -q "YOUR_.*_API_KEY" "$claude_json" 2>/dev/null; then
      warn "Some API keys in .claude.json use placeholders"
      ((WARNINGS++))
    fi
  fi
  
  # Check profile
  if [ ! -f "$profile_json" ]; then
    error "OpenClaude profile missing: $profile_json"
    ((ERRORS++))
  else
    info "Profile found"
    
    if validate_json "$profile_json"; then
      info "Profile JSON valid"
    else
      error "Invalid JSON in $profile_json"
      ((ERRORS++))
    fi
  fi
  
  # Check config directory
  if [ ! -f "$config_file" ]; then
    error "OpenClaude config file missing: $config_file"
    ((ERRORS++))
  else
    info "Config file found"
    
    if validate_json "$config_file"; then
      info "Config JSON valid"
    else
      error "Invalid JSON in $config_file"
      ((ERRORS++))
    fi
  fi
  
  # Check skills directory
  if [ ! -d "$skills_dir" ]; then
    error "OpenClaude skills directory missing"
    ((ERRORS++))
  else
    local skill_count=$(ls -1 "$skills_dir" | wc -l | tr -d ' ')
    if [ "$skill_count" -eq 0 ]; then
      error "No skills found in $skills_dir"
      ((ERRORS++))
    else
      info "Found $skill_count skills"
    fi
  fi
  
  echo ""
}

# Run validations
validate_opencode
validate_openclaude

# Summary
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  info "✓ All checks passed!"
  echo ""
  exit 0
elif [ $ERRORS -eq 0 ]; then
  warn "Validation complete with $WARNINGS warning(s)"
  echo ""
  exit 0
else
  error "Validation failed with $ERRORS error(s) and $WARNINGS warning(s)"
  echo ""
  exit 1
fi
