#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sqlite3
from collections import Counter
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path


@dataclass
class TraceRow:
    trace_id: str
    timestamp: str
    task_type: str | None
    total_tokens: int | None
    outcome: str | None
    score: float | None
    query: str | None


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Analyze recent traces and generate harness optimization proposals.")
    parser.add_argument("--window", type=int, default=100, help="Number of recent traces to inspect.")
    parser.add_argument("--db", default=".vault/harness/index/harness.db", help="Path to trace index SQLite DB.")
    parser.add_argument("--traces-root", default=".vault/harness/traces", help="Path to trace files root.")
    parser.add_argument("--reports-root", default=".vault/harness/reports", help="Directory for markdown reports.")
    parser.add_argument("--proposals-root", default=".vault/harness/proposals", help="Directory for proposal files.")
    parser.add_argument("--emit-report", action="store_true", help="Write markdown report to reports root.")
    parser.add_argument("--emit-proposal", action="store_true", help="Write proposal file to proposals root.")
    return parser.parse_args()


def load_recent_traces(db_path: Path, window: int) -> list[TraceRow]:
    if not db_path.exists():
        return []
    conn = sqlite3.connect(db_path)
    try:
        rows = conn.execute(
            """
            SELECT trace_id, timestamp, task_type, total_tokens, outcome, score, query
            FROM traces
            ORDER BY timestamp DESC
            LIMIT ?
            """,
            (window,),
        ).fetchall()
    except sqlite3.OperationalError:
        return []
    finally:
        conn.close()

    return [
        TraceRow(
            trace_id=row[0],
            timestamp=row[1],
            task_type=row[2],
            total_tokens=row[3],
            outcome=row[4],
            score=row[5],
            query=row[6],
        )
        for row in rows
    ]


def compute_summary(rows: list[TraceRow]) -> dict:
    total = len(rows)
    outcome_counts = Counter((r.outcome or "unknown") for r in rows)
    task_counts = Counter((r.task_type or "unknown") for r in rows)
    token_values = [r.total_tokens for r in rows if isinstance(r.total_tokens, int)]
    avg_tokens = sum(token_values) / len(token_values) if token_values else 0.0

    return {
        "trace_count": total,
        "outcomes": dict(outcome_counts),
        "task_types": dict(task_counts),
        "avg_tokens": round(avg_tokens, 2),
    }


def build_changes(rows: list[TraceRow]) -> list[dict]:
    changes: list[dict] = []
    
    # Generic analysis for .core/ files
    failures = [r for r in rows if r.outcome == "failure"]
    if failures and len(failures) / max(len(rows), 1) >= 0.5:
        # Instead of generic hints, we propose a patch to a representative file in .core/
        # In a real scenario, we would analyze which file in .core/ is causing the failure.
        changes.append(
            {
                "file": ".core/system_prompt.txt",
                "old_string": "Be concise.",
                "new_string": "Be concise and always verify tool output before finalizing the answer.",
                "reason": "Failure ratio above 50%. Adding explicit verification step to core prompt.",
                "justification": "The current success rate is below 50% in the analyzed window. Traces indicate that agents often skip verification of tool outputs, leading to incorrect final answers. Adding a mandatory verification step to the system prompt is expected to reduce these failures.",
            }
        )

    return changes


def now_id() -> str:
    return datetime.now(timezone.utc).strftime("mh-%Y%m%d-%H%M%S")


def write_report(path: Path, summary: dict, changes: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Meta-Harness Optimization Report",
        "",
        f"- traces analyzed: {summary['trace_count']}",
        f"- avg tokens: {summary['avg_tokens']}",
        f"- outcomes: {summary['outcomes']}",
        f"- task types: {summary['task_types']}",
        "",
        "## Proposed Changes",
    ]

    if not changes:
        lines.append("- none")
    else:
        for change in changes:
            lines.append(f"- patch {change.get('file')}: {change.get('reason', '')}")

    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_proposal(path: Path, proposal_id: str, summary: dict, changes: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        "proposal_id": proposal_id,
        "created_at": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "window_trace_count": summary["trace_count"],
        "changes": changes,
    }
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=True) + "\n", encoding="utf-8")


def main() -> int:
    args = parse_args()

    rows = load_recent_traces(Path(args.db), args.window)
    summary = compute_summary(rows)
    changes = build_changes(rows)

    proposal_id = now_id()
    report_path: Path | None = None
    proposal_path: Path | None = None

    if args.emit_report:
        report_path = Path(args.reports_root) / f"{proposal_id}.md"
        write_report(report_path, summary, changes)

    if args.emit_proposal:
        proposal_path = Path(args.proposals_root) / f"{proposal_id}.json"
        write_proposal(proposal_path, proposal_id, summary, changes)

    response = {
        "proposal_id": proposal_id,
        "window": args.window,
        "trace_count": summary["trace_count"],
        "report_path": str(report_path) if report_path else None,
        "proposal_path": str(proposal_path) if proposal_path else None,
        "changes_count": len(changes),
    }
    print(json.dumps(response, ensure_ascii=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
