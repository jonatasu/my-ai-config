#!/bin/bash
# Main installer for my-ai-config
# Installs portable AI tool configurations with interactive setup

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"

# Source libraries
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/api-keys.sh"

# Banner
echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   My AI Config - Installer v1.0      ║"
echo "║   Portable configs for AI CLI tools  ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Detect OS
OS=$(detect_os)
info "Detected OS: $OS"
echo ""

# Check prerequisites
step "Checking prerequisites..."
require_command "git" "Install from https://git-scm.com"
require_command "node" "Install from https://nodejs.org (required for MCP servers)"
info "All prerequisites met"
echo ""

# Interactive menu
echo "Which tools do you want to configure?"
echo "  1) OpenCode only"
echo "  2) OpenClaude only"
echo "  3) Both OpenCode and OpenClaude (default)"
echo ""
read -p "Enter choice [1-3] (default: 3): " choice
choice=${choice:-3}

INSTALL_OPENCODE=false
INSTALL_OPENCLAUDE=false

case $choice in
  1)
    INSTALL_OPENCODE=true
    info "Installing: OpenCode"
    ;;
  2)
    INSTALL_OPENCLAUDE=true
    info "Installing: OpenClaude"
    ;;
  3|*)
    INSTALL_OPENCODE=true
    INSTALL_OPENCLAUDE=true
    info "Installing: OpenCode + OpenClaude"
    ;;
esac
echo ""

# Backup existing configs
bash "$SCRIPT_DIR/scripts/backup.sh"

# Collect API keys
step "API Key Setup"
echo "See docs/API_KEYS.md for where to get these keys"
echo ""

collect_required_keys
collect_optional_keys
export_api_keys

show_keys_summary

# Check Ollama
OLLAMA_STATUS=$(check_ollama)
if [ "$OLLAMA_STATUS" = "detected" ]; then
  info "Ollama detected! Fetching installed models..."
  OLLAMA_MODELS=$(get_ollama_models)
  if [ -n "$OLLAMA_MODELS" ]; then
    info "Found Ollama models:"
    echo "$OLLAMA_MODELS" | while read -r model; do
      echo "  - $model"
    done
    warn "Note: Using default models in template (customize later if needed)"
  fi
  echo ""
else
  warn "Ollama not found - using default models in template"
  warn "Install Ollama from https://ollama.com if you want local models"
  echo ""
fi

# Install OpenCode
if [ "$INSTALL_OPENCODE" = true ]; then
  step "Installing OpenCode configuration..."
  
  CONFIG_DIR="$HOME/.config/opencode"
  ensure_dir "$CONFIG_DIR"
  
  # Copy skills
  info "Copying 54 skills (14MB)..."
  cp -r "$REPO_DIR/configs/skills" "$CONFIG_DIR/" || error "Failed to copy skills"
  
  # Copy and configure config file
  info "Creating opencode.json..."
  cp "$REPO_DIR/configs/opencode/opencode.json.template" "$CONFIG_DIR/opencode.json"
  
  # Replace API keys
  replace_api_keys "$CONFIG_DIR/opencode.json"
  
  info "✓ OpenCode installed at $CONFIG_DIR"
  echo ""
fi

# Install OpenClaude
if [ "$INSTALL_OPENCLAUDE" = true ]; then
  step "Installing OpenClaude configuration..."
  
  CONFIG_DIR="$HOME/.config/openclaude"
  ensure_dir "$CONFIG_DIR"
  
  # Copy skills
  info "Copying 54 skills (14MB)..."
  cp -r "$REPO_DIR/configs/skills" "$CONFIG_DIR/" || error "Failed to copy skills"
  
  # Copy main config
  info "Creating .claude.json..."
  cp "$REPO_DIR/configs/openclaude/.claude.json.template" "$HOME/.claude.json"
  replace_api_keys "$HOME/.claude.json"
  
  # Replace /Users/YOUR_USERNAME with actual home
  replace_in_file "$HOME/.claude.json" "/Users/YOUR_USERNAME" "$HOME"
  
  # Copy profile
  info "Creating .openclaude-profile.json..."
  cp "$REPO_DIR/configs/openclaude/.openclaude-profile.json.template" "$HOME/.openclaude-profile.json"
  replace_api_keys "$HOME/.openclaude-profile.json"
  
  # Copy custom commands
  info "Creating openclaude.json..."
  cp "$REPO_DIR/configs/openclaude/openclaude.json.template" "$CONFIG_DIR/openclaude.json"
  
  info "✓ OpenClaude installed at $CONFIG_DIR and $HOME"
  echo ""
fi

# Validate installation
bash "$SCRIPT_DIR/scripts/validate.sh"

# Success message
echo "╔═══════════════════════════════════════╗"
echo "║     ✓ Installation Complete!         ║"
echo "╚═══════════════════════════════════════╝"
echo ""

if [ "$INSTALL_OPENCODE" = true ]; then
  echo "OpenCode:"
  echo "  Config: $HOME/.config/opencode/opencode.json"
  echo "  Skills: $HOME/.config/opencode/skills/ (54 skills)"
  echo ""
fi

if [ "$INSTALL_OPENCLAUDE" = true ]; then
  echo "OpenClaude:"
  echo "  Config: $HOME/.claude.json"
  echo "  Profile: $HOME/.openclaude-profile.json"
  echo "  Commands: $HOME/.config/openclaude/openclaude.json"
  echo "  Skills: $HOME/.config/openclaude/skills/ (54 skills)"
  echo ""
fi

echo "Next Steps:"
echo "  1. Start your AI tool (OpenCode/OpenClaude)"
echo "  2. Try custom commands: /test, /commit, /refactor, etc."
echo "  3. Edit configs to add skipped API keys if needed"
echo "  4. Run './sync.sh' to sync changes back to repo"
echo ""
echo "Documentation:"
echo "  - API Keys: $REPO_DIR/docs/API_KEYS.md"
echo "  - Tools Comparison: $REPO_DIR/docs/TOOLS_COMPARISON.md"
echo ""
info "Happy coding! 🚀"
echo ""
