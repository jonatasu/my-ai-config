#!/usr/bin/env python3

from __future__ import annotations

import subprocess
import sys
import json
from pathlib import Path
from typing import Any

def run_cmd(cmd: list[str], cwd: Path | None = None) -> str:
    result = subprocess.run(
        cmd, 
        capture_output=True, 
        text=True, 
        cwd=str(cwd) if cwd else None, 
        check=True
    )
    return result.stdout.strip()

def git_proposal(proposal_path: Path) -> None:
    # 1. Load proposal to get details for commit message
    proposal = json.loads(proposal_path.read_text(encoding="utf-8"))
    proposal_id = proposal.get("proposal_id", "unknown")
    changes = proposal.get("changes", [])
    
    # Extract justification or reason from first change as a fallback
    justification = "Harness optimization based on trace analysis"
    if changes:
        reason = changes[0].get("reason") or changes[0].get("justification")
        if reason:
            justification = reason

    # 2. Setup environment
    repo_root = Path("/Users/jonatas.vieira.ext/Github_repos/my-ai-config/")
    branch_name = f"proposal/{proposal_id}"
    
    try:
        # Ensure we are on main and updated
        run_cmd(["git", "checkout", "main"], cwd=repo_root)
        run_cmd(["git", "pull", "origin", "main"], cwd=repo_root)

        # 3. Create Temp Branch
        run_cmd(["git", "checkout", "-b", branch_name], cwd=repo_root)

        # 4. Apply Patch
        # We call apply_patch.py with --apply to perform the actual file writes
        subprocess.run(
            ["python3", ".tools/harness/scripts/apply_patch.py", "--proposal", str(proposal_path), "--apply"],
            cwd=repo_root,
            check=True
        )

        # 5. Commit
        run_cmd(["git", "add", "."], cwd=repo_root)
        commit_msg = f"harness: apply proposal {proposal_id}\n\n{justification}"
        run_cmd(["git", "commit", "-m", commit_msg], cwd=repo_root)

        # 6. Merge to Main (Direct Merge as requested)
        run_cmd(["git", "checkout", "main"], cwd=repo_root)
        run_cmd(["git", "merge", branch_name], cwd=repo_root)

        # 7. Push to Remote
        run_cmd(["git", "push", "origin", "main"], cwd=repo_root)

        # 8. Delete Branch
        run_cmd(["git", "branch", "-D", branch_name], cwd=repo_root)
        
        print(f"Successfully merged proposal {proposal_id} to main.")

    except subprocess.CalledProcessError as e:
        print(f"Git workflow failed: {e.stderr}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--proposal", required=True, help="Path to proposal JSON")
    args = parser.parse_args()
    
    git_proposal(Path(args.proposal))
