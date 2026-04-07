#!/bin/bash
# Backup existing configurations before installation

set -e

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

# Backup directory with timestamp
BACKUP_DIR="$HOME/.ai-config-backups/$(date +%Y%m%d_%H%M%S)"

echo ""
step "Creating backup of existing configurations..."

# Create backup directory
ensure_dir "$BACKUP_DIR"

# Track if anything was backed up
BACKED_UP=false

# Backup OpenCode
if [ -d "$HOME/.config/opencode" ]; then
  info "Backing up OpenCode config..."
  backup_dir "$HOME/.config/opencode" "$BACKUP_DIR"
  BACKED_UP=true
fi

# Backup OpenClaude
if [ -f "$HOME/.claude.json" ]; then
  info "Backing up OpenClaude main config..."
  backup_file "$HOME/.claude.json" "$BACKUP_DIR"
  BACKED_UP=true
fi

if [ -f "$HOME/.openclaude-profile.json" ]; then
  info "Backing up OpenClaude profile..."
  backup_file "$HOME/.openclaude-profile.json" "$BACKUP_DIR"
  BACKED_UP=true
fi

if [ -d "$HOME/.config/openclaude" ]; then
  info "Backing up OpenClaude config directory..."
  backup_dir "$HOME/.config/openclaude" "$BACKUP_DIR"
  BACKED_UP=true
fi

if [ "$BACKED_UP" = true ]; then
  info "Backup created at: $BACKUP_DIR"
  echo ""
else
  warn "No existing configurations found to backup"
  # Remove empty backup directory
  rmdir "$BACKUP_DIR" 2>/dev/null || true
  rmdir "$HOME/.ai-config-backups" 2>/dev/null || true
  echo ""
fi
