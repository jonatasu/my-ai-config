import json
import sys
import argparse

def select_tools(policy_path, profile_name=None, query=None):
    with open(policy_path, 'r') as f:
        # Using a simple replacement for YAML to JSON if it's a simple structure
        # Or just rewrite the config as JSON for stability.
        import yaml # Trying to use a safe load if possible, but for this task I will rewrite config as JSON
        pass

def load_json_policy(path):
    with open(path, 'r') as f:
        return json.load(f)

def select_tools_json(policy_path, profile_name=None, query=None):
    policy = load_json_policy(policy_path)

    if query and query in policy['profiles']:
        profile_name = query
    
    if not profile_name:
        return {"error": "No valid profile name provided."}

    profile = policy['profiles'].get(profile_name)
    if not profile:
        return {"error": f"Profile '{profile_name}' not found."}

    budget = profile.get('budget', policy.get('global_budget', 100))
    selected_tools = []
    current_cost = 0

    for tool in profile['tools']:
        if current_cost + tool['cost'] <= budget:
            selected_tools.append(tool['mcp'])
            current_cost += tool['cost']
        else:
            break

    return {
        "profile": profile_name,
        "selected_tools": selected_tools,
        "total_cost": current_cost,
        "budget": budget
    }

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--policy", default=".tools/harness/config/opencode_policy.json")
    parser.add_argument("--profile", help="Name of the MCP profile")
    parser.add_argument("--query", help="Query to determine the profile")
    args = parser.parse_args()

    result = select_tools_json(args.policy, args.profile, args.query)
    print(json.dumps(result, indent=2))
