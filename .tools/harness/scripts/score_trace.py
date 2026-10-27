#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import os
import sqlite3
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[3]
DEFAULT_HARNESS_ROOT = Path(os.environ.get("HARNESS_ROOT", REPO_ROOT / ".harness"))
DEFAULT_DB_PATH = Path(os.environ.get("HARNESS_DB_PATH", DEFAULT_HARNESS_ROOT / "index" / "harness.db"))

VALID_OUTCOMES = {"success", "fail"}
OUTCOME_ALIASES = {"failure": "fail"}

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Score a trace based on performance metrics.")
    parser.add_argument("--db", default=str(DEFAULT_DB_PATH), help="Path to trace index SQLite database.")
    parser.add_argument("--trace-id", required=True, help="Trace identifier to score.")
    parser.add_argument(
        "--outcome",
        choices=["success", "fail", "failure"],
        help="Persist an explicit trace outcome instead of using the indexed outcome.",
    )
    parser.add_argument(
        "--score",
        type=float,
        help="Persist an explicit score between 0 and 1 instead of calculating one.",
    )
    args = parser.parse_args()
    if args.score is not None and not 0.0 <= args.score <= 1.0:
        parser.error("--score must be between 0 and 1")
    return args

def calculate_score(trace_data: dict) -> float:
    """
    Formula: success / total_tokens + penalties for tool-overflows.
    """
    # We need the raw trace file to calculate penalties (e.g. tool overflows)
    trace_path = Path(trace_data["trace_path"])
    if not trace_path.exists():
        raise FileNotFoundError(f"Trace file not found: {trace_path}")
    
    trace_content = json.loads(trace_path.read_text(encoding="utf-8"))
    
    # Basic score: 1 if successful, 0 otherwise.
    # Using a simplified version of the requested formula since 'success' is boolean
    outcome = trace_data.get("outcome", "fail")
    success_val = 1.0 if outcome == "success" else 0.0
    
    tokens = trace_data.get("total_tokens") or 1 # avoid div by zero
    base_score = success_val / tokens
    
    # Penalty for tool overflows (assuming 'tool_overflow' is a key in the trace content)
    penalty = 0.0
    if trace_content.get("tool_overflow", False):
        penalty = 0.1 # Example penalty
        
    return max(0.0, base_score - penalty)

def main() -> int:
    args = parse_args()
    conn = sqlite3.connect(args.db)
    try:
        row = conn.execute(
            "SELECT trace_id, total_tokens, outcome, trace_path FROM traces WHERE trace_id = ?", 
            (args.trace_id,)
        ).fetchone()
        
        if row is None:
            print(f"trace_id not found: {args.trace_id}", file=sys.stderr)
            return 1
        
        raw_outcome = args.outcome if args.outcome else row[2]
        outcome = OUTCOME_ALIASES.get(raw_outcome, raw_outcome) or "fail"
        if outcome not in VALID_OUTCOMES:
            raise ValueError(f"unsupported trace outcome: {outcome}")
        trace_data = {
            "trace_id": row[0],
            "total_tokens": row[1],
            "outcome": outcome,
            "trace_path": row[3]
        }
        
        score = args.score if args.score is not None else calculate_score(trace_data)
        
        conn.execute(
            "UPDATE traces SET outcome = ?, score = ? WHERE trace_id = ?",
            (outcome, score, args.trace_id),
        )
        conn.commit()
        print(f"Trace {args.trace_id} scored: {score}")
        
    except Exception as e:
        print(f"Error scoring trace: {e}", file=sys.stderr)
        return 1
    finally:
        conn.close()
        
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
