import os
import sys
import json

def select_mcp_profile(query, budget=100):
    """
    Filters MCPs based on a query budget.
    """
    # Simplified budget lookup to avoid PyYAML dependency for this task
    mcp_budgets = {
        'firecrawl': 50,
        'atlassian': 30,
        'playwright': 20
    }

    active_mcp = []
    remaining_budget = budget
    
    for mcp, cost in mcp_budgets.items():
        if remaining_budget >= cost:
            active_mcp.append(mcp)
            remaining_budget -= cost
            
    return active_mcp

if __name__ == "__main__":
    query_text = sys.argv[1] if len(sys.argv) > 1 else "default"
    budget_val = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    
    print(json.dumps({
        "query": query_text,
        "budget": budget_val,
        "selected_mcp": select_mcp_profile(query_text, budget_val)
    }, indent=2))
