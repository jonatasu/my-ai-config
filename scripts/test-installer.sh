#!/bin/bash
# Test installer in a clean environment
# This script simulates a fresh installation without actually modifying the system

# Don't exit on error - we want to run all tests
set +e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Installer Test - Dry Run Mode      ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Test function
test_check() {
  local test_name=$1
  local condition=$2
  
  if [ "$condition" = "true" ]; then
    echo -e "${GREEN}✓${NC} $test_name"
    ((TESTS_PASSED++))
  else
    echo -e "${RED}✗${NC} $test_name"
    ((TESTS_FAILED++))
  fi
}

# Test prerequisites
echo -e "${BLUE}→${NC} Testing prerequisites..."
echo ""

test_check "Git installed" "$(command -v git > /dev/null && echo true || echo false)"
test_check "Node.js installed" "$(command -v node > /dev/null && echo true || echo false)"
test_check "Python3 installed" "$(command -v python3 > /dev/null && echo true || echo false)"

echo ""

# Test repository structure
echo -e "${BLUE}→${NC} Testing repository structure..."
echo ""

test_check "install.sh exists" "$([ -f "$REPO_DIR/install.sh" ] && echo true || echo false)"
test_check "install.ps1 exists" "$([ -f "$REPO_DIR/install.ps1" ] && echo true || echo false)"
test_check "sync.sh exists" "$([ -f "$REPO_DIR/sync.sh" ] && echo true || echo false)"
test_check "sync.ps1 exists" "$([ -f "$REPO_DIR/sync.ps1" ] && echo true || echo false)"
test_check "configs/ directory exists" "$([ -d "$REPO_DIR/configs" ] && echo true || echo false)"
test_check "scripts/ directory exists" "$([ -d "$REPO_DIR/scripts" ] && echo true || echo false)"
test_check "docs/ directory exists" "$([ -d "$REPO_DIR/docs" ] && echo true || echo false)"

echo ""

# Test config templates
echo -e "${BLUE}→${NC} Testing config templates..."
echo ""

test_check "OpenCode template exists" "$([ -f "$REPO_DIR/configs/opencode/opencode.json.template" ] && echo true || echo false)"
test_check "OpenClaude .claude.json template exists" "$([ -f "$REPO_DIR/configs/openclaude/.claude.json.template" ] && echo true || echo false)"
test_check "OpenClaude profile template exists" "$([ -f "$REPO_DIR/configs/openclaude/.openclaude-profile.json.template" ] && echo true || echo false)"
test_check "OpenClaude commands template exists" "$([ -f "$REPO_DIR/configs/openclaude/openclaude.json.template" ] && echo true || echo false)"

echo ""

# Test skills
echo -e "${BLUE}→${NC} Testing skills..."
echo ""

SKILLS_DIR="$REPO_DIR/configs/skills"
SKILL_COUNT=0

if [ -d "$SKILLS_DIR" ]; then
  SKILL_COUNT=$(ls -1 "$SKILLS_DIR" | wc -l | tr -d ' ')
fi

test_check "Skills directory exists" "$([ -d "$SKILLS_DIR" ] && echo true || echo false)"
test_check "Skills count >= 50" "$([ $SKILL_COUNT -ge 50 ] && echo true || echo false)"
echo "  Found $SKILL_COUNT skills"

echo ""

# Test helper scripts
echo -e "${BLUE}→${NC} Testing helper scripts..."
echo ""

test_check "scripts/lib/common.sh exists" "$([ -f "$REPO_DIR/scripts/lib/common.sh" ] && echo true || echo false)"
test_check "scripts/lib/common.ps1 exists" "$([ -f "$REPO_DIR/scripts/lib/common.ps1" ] && echo true || echo false)"
test_check "scripts/lib/api-keys.sh exists" "$([ -f "$REPO_DIR/scripts/lib/api-keys.sh" ] && echo true || echo false)"
test_check "scripts/lib/api-keys.ps1 exists" "$([ -f "$REPO_DIR/scripts/lib/api-keys.ps1" ] && echo true || echo false)"
test_check "scripts/lib/mcp-filter.py exists" "$([ -f "$REPO_DIR/scripts/lib/mcp-filter.py" ] && echo true || echo false)"
test_check "scripts/backup.sh exists" "$([ -f "$REPO_DIR/scripts/backup.sh" ] && echo true || echo false)"
test_check "scripts/backup.ps1 exists" "$([ -f "$REPO_DIR/scripts/backup.ps1" ] && echo true || echo false)"
test_check "scripts/validate.sh exists" "$([ -f "$REPO_DIR/scripts/validate.sh" ] && echo true || echo false)"
test_check "scripts/validate.ps1 exists" "$([ -f "$REPO_DIR/scripts/validate.ps1" ] && echo true || echo false)"

echo ""

# Test documentation
echo -e "${BLUE}→${NC} Testing documentation..."
echo ""

test_check "README.md exists" "$([ -f "$REPO_DIR/README.md" ] && echo true || echo false)"
test_check "API_KEYS.md exists" "$([ -f "$REPO_DIR/docs/API_KEYS.md" ] && echo true || echo false)"
test_check "WINDOWS_SETUP.md exists" "$([ -f "$REPO_DIR/docs/WINDOWS_SETUP.md" ] && echo true || echo false)"
test_check "TOOLS_COMPARISON.md exists" "$([ -f "$REPO_DIR/docs/TOOLS_COMPARISON.md" ] && echo true || echo false)"
test_check "MIGRATION.md exists" "$([ -f "$REPO_DIR/docs/MIGRATION.md" ] && echo true || echo false)"

echo ""

# Test JSON validity
echo -e "${BLUE}→${NC} Testing JSON validity..."
echo ""

validate_json() {
  local file=$1
  if command -v python3 > /dev/null; then
    python3 -m json.tool "$file" > /dev/null 2>&1
    return $?
  elif command -v node > /dev/null; then
    node -e "JSON.parse(require('fs').readFileSync('$file', 'utf8'))" > /dev/null 2>&1
    return $?
  else
    return 0
  fi
}

test_check "OpenCode template is valid JSON" "$(validate_json "$REPO_DIR/configs/opencode/opencode.json.template" && echo true || echo false)"
test_check "OpenClaude .claude.json is valid JSON" "$(validate_json "$REPO_DIR/configs/openclaude/.claude.json.template" && echo true || echo false)"
test_check "OpenClaude profile is valid JSON" "$(validate_json "$REPO_DIR/configs/openclaude/.openclaude-profile.json.template" && echo true || echo false)"
test_check "OpenClaude commands is valid JSON" "$(validate_json "$REPO_DIR/configs/openclaude/openclaude.json.template" && echo true || echo false)"

echo ""

# Test placeholders
echo -e "${BLUE}→${NC} Testing API key placeholders..."
echo ""

check_placeholders() {
  local file=$1
  grep -q "YOUR_.*_API_KEY" "$file" 2>/dev/null
  return $?
}

test_check "OpenCode has placeholders" "$(check_placeholders "$REPO_DIR/configs/opencode/opencode.json.template" && echo true || echo false)"
test_check "OpenClaude .claude.json has placeholders" "$(check_placeholders "$REPO_DIR/configs/openclaude/.claude.json.template" && echo true || echo false)"

echo ""

# Test no secrets committed
echo -e "${BLUE}→${NC} Testing for committed secrets..."
echo ""

check_no_secrets() {
  local file=$1
  # Check for common API key patterns that shouldn't be in templates
  if grep -qE "(sk-[a-zA-Z0-9]{20,}|gsk_[a-zA-Z0-9]{20,}|fc-[a-zA-Z0-9]{20,}|ctx7sk-[a-zA-Z0-9]{20,}|AIza[a-zA-Z0-9]{20,})" "$file" 2>/dev/null; then
    return 1
  fi
  return 0
}

test_check "OpenCode template has no real keys" "$(check_no_secrets "$REPO_DIR/configs/opencode/opencode.json.template" && echo true || echo false)"
test_check "OpenClaude template has no real keys" "$(check_no_secrets "$REPO_DIR/configs/openclaude/.claude.json.template" && echo true || echo false)"

echo ""

# Summary
echo "╔═══════════════════════════════════════╗"
if [ $TESTS_FAILED -eq 0 ]; then
  echo -e "║  ${GREEN}✓ All Tests Passed!${NC}                 ║"
else
  echo -e "║  ${RED}✗ Some Tests Failed${NC}                 ║"
fi
echo "╚═══════════════════════════════════════╝"
echo ""
echo "Results:"
echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
  echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
fi
echo ""

if [ $TESTS_FAILED -gt 0 ]; then
  exit 1
fi

exit 0
