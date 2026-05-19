#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sqlite3
import sys
from pathlib import Path

VALID_OUTCOMES = {"success", "failure"}

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Score a trace based on performance metrics.")
    parser.add_argument("--db", default="/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/harness/index/harness.db", help="Path to trace index SQLite database.")
    parser.add_argument("--trace-id", required=True, help="Trace identifier to score.")
    args = parser.parse_args()
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
    outcome = trace_data.get("outcome", "failure")
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
        
        trace_data = {
            "trace_id": row[0],
            "total_tokens": row[1],
            "outcome": row[2],
            "trace_path": row[3]
        }
        
        score = calculate_score(trace_data)
        
        conn.execute("UPDATE traces SET score = ? WHERE trace_id = ?", (score, args.trace_id))
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
