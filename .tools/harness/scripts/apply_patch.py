#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import shutil
import sys
from datetime import datetime, timezone
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Validate and apply harness proposal changes safely.")
    parser.add_argument("--proposal", required=True, help="Path to proposal JSON file.")
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--dry-run", action="store_true", help="Validate and simulate changes without writing config.")
    mode.add_argument("--apply", action="store_true", help="Apply proposal changes to config.")
    mode.add_argument("--mode-git", action="store_true", help="Apply proposal changes through Git workflow.")
    parser.add_argument("--backup-dir", default=".vault/harness/backups", help="Directory to store timestamped backups.")
    return parser.parse_args()


def load_proposal(path: Path) -> dict:
    proposal = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(proposal, dict):
        raise ValueError("proposal must be a JSON object")
    if "changes" not in proposal or not isinstance(proposal["changes"], list):
        raise ValueError("proposal must include a 'changes' array")
    return proposal


def apply_patch(file_path: Path, old_string: str, new_string: str) -> None:
    if not file_path.exists():
        raise FileNotFoundError(f"Target file not found: {file_path}")
    
    content = file_path.read_text(encoding="utf-8")
    if old_string not in content:
        raise ValueError(f"Old string not found in {file_path}")
    
    new_content = content.replace(old_string, new_string)
    file_path.write_text(new_content, encoding="utf-8")


def backup_file(file_path: Path, backup_dir: Path) -> Path:
    backup_dir.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    # Keep original path structure in backup
    relative_path = file_path.relative_to(file_path.anchor)
    backup_path = backup_dir / f"{relative_path}.{stamp}.bak"
    backup_path.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(file_path, backup_path)
    return backup_path


def main() -> int:
    args = parse_args()
    proposal_path = Path(args.proposal)
    backup_dir = Path(args.backup_dir)

    if not proposal_path.exists():
        print(f"proposal file not found: {proposal_path}", file=sys.stderr)
        return 1

    try:
        proposal = load_proposal(proposal_path)
        changes = proposal.get("changes", [])
    except ValueError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    if args.dry_run:
        results = []
        for change in changes:
            file_path = Path(change.get("file", ""))
            if file_path.exists():
                results.append({"file": str(file_path), "status": "found"})
            else:
                results.append({"file": str(file_path), "status": "not_found"})
        
        response = {
            "status": "dry_run",
            "proposal_id": proposal.get("proposal_id"),
            "changes_count": len(changes),
            "verification": results,
        }
        print(json.dumps(response, ensure_ascii=True))
        return 0

    if args.mode_git:
        import subprocess
        try:
            # Seamless handover to git_proposal.py
            subprocess.run(
                ["python3", ".tools/harness/scripts/git_proposal.py", "--proposal", str(proposal_path)],
                check=True
            )
            response = {
                "status": "git_applied",
                "proposal_id": proposal.get("proposal_id"),
                "changes_count": len(changes),
            }
            print(json.dumps(response, ensure_ascii=True))
            return 0
        except subprocess.CalledProcessError as e:
            print(f"Git workflow failed: {e}", file=sys.stderr)
            return 1

    try:
        backups = []
        for change in changes:
            file_path = Path(change.get("file", ""))
            old_str = change.get("old_string")
            new_str = change.get("new_string")
            
            if not file_path.exists():
                print(f"Skipping missing file: {file_path}", file=sys.stderr)
                continue
                
            backup_path = backup_file(file_path, backup_dir)
            backups.append(str(backup_path))
            apply_patch(file_path, old_str, new_str)
            
    except Exception as exc:
        print(f"apply failed: {exc}", file=sys.stderr)
        return 1

    response = {
        "status": "applied",
        "proposal_id": proposal.get("proposal_id"),
        "backups": backups,
        "changes_count": len(changes),
    }
    print(json.dumps(response, ensure_ascii=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
