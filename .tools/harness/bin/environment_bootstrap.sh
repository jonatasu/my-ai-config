#!/bin/bash
set -e

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${AI_CONFIG_ROOT:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
ENV_FILE="${AI_CONFIG_ENV_FILE:-$REPO_ROOT/.env}"
CONFIG_DIR="${AI_CONFIG_CONFIG_DIR:-$REPO_ROOT/.tools/mcp_setup/configs}"
HARNESS_ROOT="${HARNESS_ROOT:-$REPO_ROOT/.harness}"
ACTIVE_CONFIG_DIR="${AI_CONFIG_ACTIVE_DIR:-$HARNESS_ROOT/active-configs}"

mkdir -p "$ACTIVE_CONFIG_DIR"

if [ -f "$ENV_FILE" ]; then
    # Load .env variables into environment.
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "No .env file found; using exported environment variables."
fi

echo "Bootstrapping environment configs..."

for config_file in "$CONFIG_DIR"/*.json; do
    filename=$(basename "$config_file")
    target_file="$ACTIVE_CONFIG_DIR/$filename"
    
    echo "Processing $filename -> $target_file"
    
    # Use envsubst to replace ${VAR} with environment variables
    # If envsubst isn't available, we use a sed-based fallback for simple ${VAR}
    if command -v envsubst >/dev/null 2>&1; then
        envsubst < "$config_file" > "$target_file"
    else
        # Fallback: iterate through .env keys and replace
        cp "$config_file" "$target_file"
        keys=$(grep -o '\${[A-Za-z_][A-Za-z0-9_]*}' "$config_file" | tr -d '${}' | sort -u)
        while IFS= read -r key; do
            [ -z "$key" ] && continue
            value=$(printenv "$key" || true)
            # Escape value for sed
            escaped_val=$(echo "$value" | sed 's/[\/&]/\\&/g')
            sed -i "" "s/\${$key}/$escaped_val/g" "$target_file"
        done <<< "$keys"
    fi
done

echo "Done. Configs available in $ACTIVE_CONFIG_DIR"
