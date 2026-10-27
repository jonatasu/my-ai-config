#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import os
import uuid
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = Path(os.environ.get("AI_CONFIG_ROOT", SCRIPT_DIR.parents[2]))
HARNESS_ROOT = Path(os.environ.get("HARNESS_ROOT", REPO_ROOT / ".harness"))


def load_policy() -> dict[str, Any]:
    policy_path = REPO_ROOT / ".tools" / "harness" / "harness_policy.yaml"
    if policy_path.exists():
        try:
            import yaml
            with policy_path.open("r", encoding="utf-8") as f:
                return yaml.safe_load(f)
        except ImportError:
            pass
    return {}

def main() -> int:
    parser = argparse.ArgumentParser(description="Generic Trace Collector")
    parser.add_argument("--agent-id", required=True)
    parser.add_argument("--query", required=True)
    parser.add_argument("--outcome", choices=["success", "fail"], required=True)
    parser.add_argument("--tokens", type=int, default=0)
    parser.add_argument("--score", type=float, default=None)
    parser.add_argument("--tools", default="[]")
    parser.add_argument("--trace-content", default="")
    
    args = parser.parse_args()
    
    policy = load_policy()
    configured_root = os.getenv("TRACE_ROOT")
    root_dir = Path(configured_root or policy.get("trace_root", ".harness/logs"))
    if not root_dir.is_absolute():
        root_dir = HARNESS_ROOT / root_dir.relative_to(".harness") if str(root_dir).startswith(".harness/") else HARNESS_ROOT / root_dir
    
    timestamp = datetime.now(timezone.utc)
    # Structure: .harness/logs/<agent_id>/<year-month-day>/
    partition = root_dir / args.agent_id / timestamp.strftime("%Y-%m-%d")
    partition.mkdir(parents=True, exist_ok=True)
    
    trace_id = str(uuid.uuid4())
    payload = {
        "agent_id": args.agent_id,
        "timestamp": timestamp.isoformat().replace("+00:00", "Z"),
        "query": args.query,
        "tools_used": json.loads(args.tools),
        "tokens_consumed": args.tokens,
        "outcome": args.outcome,
        "redacted_trace": args.trace_content
    }
    if args.score is not None:
        payload["score"] = args.score
    
    trace_path = partition / f"{trace_id}.json"
    trace_path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    
    print(f"Trace saved to: {trace_path}")
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main())
