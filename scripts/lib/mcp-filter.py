#!/usr/bin/env python3
"""
Remove disabled MCPs from OpenClaude .claude.json config
"""

import json
import sys


def remove_mcp_servers(config_file, disabled_mcps):
    """Remove disabled MCP servers from config"""
    with open(config_file, "r") as f:
        config = json.load(f)

    # Navigate to mcpServers in projects section
    if "projects" in config:
        for project in config["projects"].values():
            if "mcpServers" in project:
                for mcp_name in disabled_mcps:
                    if mcp_name in project["mcpServers"]:
                        del project["mcpServers"][mcp_name]

    # Write back
    with open(config_file, "w") as f:
        json.dump(config, f, indent=2)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: mcp-filter.py <config_file> <mcp1,mcp2,...>")
        sys.exit(1)

    config_file = sys.argv[1]
    disabled_mcps = sys.argv[2].split(",") if sys.argv[2] else []

    remove_mcp_servers(config_file, disabled_mcps)
    print(f"Removed {len(disabled_mcps)} disabled MCPs from {config_file}")
