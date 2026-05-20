#!/bin/bash

# Opencode Bootstrap Mechanism
# Goal: Ensure agent starts with the latest DNA and verify configuration integrity.

REPO_ROOT="/Users/jonatas.vieira.ext/Github_repos/my-ai-config"
cd "$REPO_ROOT" || exit 1

echo "## 🧬 Opencode Bootstrap Summary"
echo "Date: $(date)"
echo ""

# 1. Sync Configuration
echo "### 🔄 Syncing Config"
if git pull; then
    echo "✅ Latest config pulled successfully."
else
    echo "⚠️ Git pull failed or no remote configured."
fi

# 2. Integrity Check
echo ""
echo "### 🛠️ Structural Integrity"
CORE_DIR=".core"
RULES_DIR=".rules"
INTEGRITY_PASS=true

if [ -d "$CORE_DIR" ]; then
    echo "✅ Core directory exists."
else
    echo "❌ Core directory missing!"
    INTEGRITY_PASS=false
fi

if [ -d "$RULES_DIR" ]; then
    echo "✅ Rules directory exists."
else
    echo "❌ Rules directory missing!"
    INTEGRITY_PASS=false
fi

if [ "$INTEGRITY_PASS" = true ]; then
    echo "Overall Integrity: PASSED"
else
    echo "Overall Integrity: FAILED"
fi

# 3. Configuration Summary
echo ""
echo "### 📋 Current State"

# Active Agent (Assumption: defined in a config file or environment)
AGENT_NAME=$(grep -h "name" .core/agent.json 2>/dev/null | head -n 1 | cut -d '"' -f 4 || echo "Opencode")
echo "- **Active Agent:** $AGENT_NAME"

# Core Persona Verification
if [ -d ".core/agents/opencode" ]; then
    echo "- **Agent Persona:** Opencode (Cognitive Layer active)"
else
    echo "- **Agent Persona:** Default (Persona not found)"
fi

# Loaded Skills (Scan .core/skills or similar)
SKILLS_COUNT=$(find .core -name "*.md" | wc -l)
echo "- **Loaded Skills:** $SKILLS_COUNT identified"

# Active Rules (Scan .rules/)
RULES_COUNT=$(find .rules -name "*.md" | wc -l)
echo "- **Active Rules:** $RULES_COUNT identified"

echo ""
echo "---"
echo "Bootstrap completed."
