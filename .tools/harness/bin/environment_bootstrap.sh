#!/bin/bash
set -e

# Paths
ENV_FILE=".env"
CONFIG_DIR=".tools/mcp_setup/configs"
ACTIVE_CONFIG_DIR=".tools/mcp_setup/active_configs"

mkdir -p "$ACTIVE_CONFIG_DIR"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found."
    exit 1
fi

# Load .env variables into environment
export $(grep -v '^#' "$ENV_FILE" | xargs)

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
        while IFS='=' read -r key value; do
            if [[ ! $key =~ ^# && -n $key ]]; then
                # Escape value for sed
                escaped_val=$(echo "$value" | sed 's/[\/&]/\\&/g')
                sed -i "" "s/\${$key}/$escaped_val/g" "$target_file"
            fi
        done < "$ENV_FILE"
    fi
done

echo "Done. Configs available in $ACTIVE_CONFIG_DIR"
