#!/bin/bash
# Sync local configuration changes back to repository
# Removes API keys before committing

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"

# Source libraries
source "$SCRIPT_DIR/scripts/lib/common.sh"

# Banner
echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Config Sync - Back to Repository   ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Check if in git repo
if [ ! -d "$REPO_DIR/.git" ]; then
  error "Not a git repository. Run this from the repo root."
fi

# Sanitize file (remove API keys)
sanitize_file() {
  local src=$1
  local dst=$2
  
  if [ ! -f "$src" ]; then
    warn "Source file not found: $src"
    return 1
  fi
  
  step "Sanitizing $(basename "$src")..."
  
  # Copy file
  cp "$src" "$dst.tmp"
  
  # Remove API keys using sed (replace with placeholders)
  sed -i.bak \
    -e 's/"apiKey": "[^"]*"/"apiKey": "YOUR_API_KEY"/g' \
    -e 's/"api_key": "[^"]*"/"api_key": "YOUR_API_KEY"/g' \
    -e 's/"API_KEY": "[^"]*"/"API_KEY": "YOUR_API_KEY"/g' \
    -e 's/"OPENAI_API_KEY": "[^"]*"/"OPENAI_API_KEY": "YOUR_OPENROUTER_API_KEY"/g' \
    -e 's/"OPENROUTER_API_KEY": "[^"]*"/"OPENROUTER_API_KEY": "YOUR_OPENROUTER_API_KEY"/g' \
    -e 's/"GROQ_API_KEY": "[^"]*"/"GROQ_API_KEY": "YOUR_GROQ_API_KEY"/g' \
    -e 's/"CONTEXT7_API_KEY": "[^"]*"/"CONTEXT7_API_KEY": "YOUR_CONTEXT7_API_KEY"/g' \
    -e 's/"FIRECRAWL_API_KEY": "[^"]*"/"FIRECRAWL_API_KEY": "YOUR_FIRECRAWL_API_KEY"/g' \
    -e 's/"Authorization": "Basic [^"]*"/"Authorization": "YOUR_ATLASSIAN_AUTH_TOKEN"/g' \
    -e 's/"ATLASSIAN_AUTH": "Basic [^"]*"/"ATLASSIAN_AUTH": "YOUR_ATLASSIAN_AUTH_TOKEN"/g' \
    -e 's/sk-[a-zA-Z0-9_-]*/YOUR_API_KEY/g' \
    -e 's/gsk_[a-zA-Z0-9_-]*/YOUR_GROQ_API_KEY/g' \
    -e 's/fc-[a-zA-Z0-9_-]*/YOUR_FIRECRAWL_API_KEY/g' \
    -e 's/ctx7sk-[a-zA-Z0-9_-]*/YOUR_CONTEXT7_API_KEY/g' \
    -e 's/AIza[a-zA-Z0-9_-]*/YOUR_GOOGLE_API_KEY/g' \
    "$dst.tmp"
  
  # Move to final destination
  mv "$dst.tmp" "$dst"
  rm -f "$dst.tmp.bak"
  
  info "✓ Sanitized $(basename "$dst")"
}

# Sync OpenCode configs
sync_opencode() {
  if [ ! -d "$HOME/.config/opencode" ]; then
    warn "OpenCode not installed, skipping"
    return 0
  fi
  
  step "Syncing OpenCode configuration..."
  
  # Sync config file
  if [ -f "$HOME/.config/opencode/opencode.json" ]; then
    sanitize_file \
      "$HOME/.config/opencode/opencode.json" \
      "$REPO_DIR/configs/opencode/opencode.json.template"
  fi
  
  # Sync skills (if changed)
  if [ -d "$HOME/.config/opencode/skills" ]; then
    info "Syncing skills directory..."
    rsync -av --delete "$HOME/.config/opencode/skills/" "$REPO_DIR/configs/skills/" \
      > /dev/null 2>&1 || warn "Skills sync had warnings (may be okay)"
  fi
  
  echo ""
}

# Sync OpenClaude configs
sync_openclaude() {
  local has_config=false
  
  [ -f "$HOME/.claude.json" ] && has_config=true
  [ -f "$HOME/.openclaude-profile.json" ] && has_config=true
  [ -d "$HOME/.config/openclaude" ] && has_config=true
  
  if [ "$has_config" = false ]; then
    warn "OpenClaude not installed, skipping"
    return 0
  fi
  
  step "Syncing OpenClaude configuration..."
  
  # Sync main config
  if [ -f "$HOME/.claude.json" ]; then
    sanitize_file \
      "$HOME/.claude.json" \
      "$REPO_DIR/configs/openclaude/.claude.json.template"
  fi
  
  # Sync profile
  if [ -f "$HOME/.openclaude-profile.json" ]; then
    sanitize_file \
      "$HOME/.openclaude-profile.json" \
      "$REPO_DIR/configs/openclaude/.openclaude-profile.json.template"
  fi
  
  # Sync custom commands
  if [ -f "$HOME/.config/openclaude/openclaude.json" ]; then
    cp "$HOME/.config/openclaude/openclaude.json" \
       "$REPO_DIR/configs/openclaude/openclaude.json.template"
    info "✓ Synced openclaude.json"
  fi
  
  # Sync skills (if changed) - only if different from OpenCode
  if [ -d "$HOME/.config/openclaude/skills" ] && [ ! -d "$HOME/.config/opencode/skills" ]; then
    info "Syncing skills from OpenClaude..."
    rsync -av --delete "$HOME/.config/openclaude/skills/" "$REPO_DIR/configs/skills/" \
      > /dev/null 2>&1 || warn "Skills sync had warnings"
  fi
  
  echo ""
}

# Perform sync
sync_opencode
sync_openclaude

# Git status
step "Checking for changes..."
if git diff --quiet && git diff --cached --quiet; then
  info "No changes to commit"
  echo ""
  exit 0
fi

echo ""
git status --short
echo ""

# Prompt for commit message
read -p "Commit message (default: 'sync: update configs'): " commit_msg
commit_msg=${commit_msg:-"sync: update configs"}

# Git operations
step "Committing changes..."
cd "$REPO_DIR"
git add .
git commit -m "$commit_msg" || warn "Nothing to commit"

step "Pushing to remote..."
git push || error "Failed to push to remote. Check your git credentials."

echo ""
info "✓ Sync complete! Changes pushed to GitHub."
echo ""

# Show latest commit
echo "Latest commit:"
git log -1 --oneline
echo ""
