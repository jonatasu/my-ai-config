#!/bin/bash
# Common utilities for installer scripts

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Output functions
info() {
  echo -e "${GREEN}✓${NC} $1"
}

warn() {
  echo -e "${YELLOW}!${NC} $1"
}

error() {
  echo -e "${RED}✗${NC} $1"
  exit 1
}

step() {
  echo -e "${BLUE}→${NC} $1"
}

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Darwin*)
      echo "mac"
      ;;
    Linux*)
      echo "linux"
      ;;
    CYGWIN*|MINGW*|MSYS*)
      error "Windows detected. Please use install.ps1 instead."
      ;;
    *)
      error "Unsupported OS: $(uname -s)"
      ;;
  esac
}

# Check if command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Require a command to be installed
require_command() {
  local cmd=$1
  local install_msg=${2:-"Please install $cmd"}
  
  if ! command_exists "$cmd"; then
    error "$cmd not found. $install_msg"
  fi
}

# Get home directory
get_home() {
  echo "$HOME"
}

# Get config directory based on OS
get_config_dir() {
  local tool=$1
  local os=$(detect_os)
  local home=$(get_home)
  
  case "$tool" in
    opencode)
      echo "$home/.config/opencode"
      ;;
    openclaude)
      echo "$home/.config/openclaude"
      ;;
    *)
      error "Unknown tool: $tool"
      ;;
  esac
}

# Create directory if it doesn't exist
ensure_dir() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" || error "Failed to create directory: $dir"
  fi
}

# Backup file if it exists
backup_file() {
  local file=$1
  local backup_dir=$2
  
  if [ -f "$file" ]; then
    ensure_dir "$backup_dir"
    cp "$file" "$backup_dir/" || warn "Failed to backup: $file"
  fi
}

# Backup directory if it exists
backup_dir() {
  local dir=$1
  local backup_dir=$2
  
  if [ -d "$dir" ]; then
    ensure_dir "$backup_dir"
    cp -r "$dir" "$backup_dir/" || warn "Failed to backup: $dir"
  fi
}

# Replace placeholder in file
replace_in_file() {
  local file=$1
  local placeholder=$2
  local value=$3
  
  if [ -f "$file" ]; then
    # Escape special characters in value for sed
    local escaped_value=$(printf '%s\n' "$value" | sed -e 's/[\/&]/\\&/g')
    sed -i.bak "s/$placeholder/$escaped_value/g" "$file"
    rm -f "$file.bak"
  else
    warn "File not found: $file"
  fi
}

# Check if Ollama is installed and get models
check_ollama() {
  if command_exists ollama; then
    echo "detected"
  else
    echo "not_installed"
  fi
}

# Get Ollama models as JSON array
get_ollama_models() {
  if ! command_exists ollama; then
    echo ""
    return
  fi
  
  # Get models from ollama list, skip header, get first column
  local models=$(ollama list 2>/dev/null | awk 'NR>1 {print $1}' | grep -v '^$')
  
  if [ -z "$models" ]; then
    echo ""
    return
  fi
  
  # Convert to JSON-like format for easy insertion
  echo "$models"
}

# Validate JSON file
validate_json() {
  local file=$1
  
  if ! command_exists python3 && ! command_exists node; then
    warn "Cannot validate JSON (neither python3 nor node found)"
    return 0
  fi
  
  if command_exists python3; then
    python3 -m json.tool "$file" > /dev/null 2>&1
    return $?
  elif command_exists node; then
    node -e "JSON.parse(require('fs').readFileSync('$file', 'utf8'))" > /dev/null 2>&1
    return $?
  fi
}
