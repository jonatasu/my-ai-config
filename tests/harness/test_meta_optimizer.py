from __future__ import annotations

import json
import sqlite3
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OPTIMIZER = ROOT / ".tools" / "harness" / "scripts" / "meta_optimizer.py"

def seed_index(db_path: Path) -> None:
    conn = sqlite3.connect(db_path)
    try:
        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS traces (
                trace_id TEXT PRIMARY KEY,
                timestamp TEXT NOT NULL,
                task_type TEXT,
                total_tokens INTEGER,
                outcome TEXT,
                score REAL,
                query TEXT,
                final_answer TEXT,
                trace_path TEXT,
                indexed_at TEXT
            )
            """
        )
        rows = [
            ("t1", "2026-05-19T10:00:00Z", "code_review", 1200, "failure", 0.0, "review diff", "", "", "2026-05-19T10:00:01Z"),
            ("t2", "2026-05-19T10:01:00Z", "code_review", 1100, "failure", 0.1, "review diff", "", "", "2026-05-19T10:01:01Z"),
            ("t3", "2026-05-19T10:02:00Z", "web_research", 400, "success", 1.0, "scrape page", "", "", "2026-05-19T10:02:01Z"),
        ]
        conn.executemany(
            """
            INSERT INTO traces(trace_id, timestamp, task_type, total_tokens, outcome, score, query, final_answer, trace_path, indexed_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            rows,
        )
        conn.commit()
    finally:
        conn.close()

def test_optimizer_emits_report_and_proposal(tmp_path: Path) -> None:
    db_path = tmp_path / "trace_index.sqlite"
    traces_root = tmp_path / "traces"
    reports_root = tmp_path / "reports"
    proposals_root = tmp_path / "proposals"
    traces_root.mkdir(parents=True, exist_ok=True)

    seed_index(db_path)

    cmd = [
        sys.executable,
        str(OPTIMIZER),
        "--window",
        "100",
        "--db",
        str(db_path),
        "--traces-root",
        str(traces_root),
        "--reports-root",
        str(reports_root),
        "--proposals-root",
        str(proposals_root),
        "--emit-report",
        "--emit-proposal",
    ]

    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    output = json.loads(result.stdout)

    report_path = Path(output["report_path"])
    proposal_path = Path(output["proposal_path"])
    assert report_path.exists()
    assert proposal_path.exists()

    proposal = json.loads(proposal_path.read_text(encoding="utf-8"))
    assert proposal["proposal_id"].startswith("mh-")
    assert isinstance(proposal["changes"], list)
    assert proposal["changes"]

def test_optimizer_outputs_summary_without_writing_files(tmp_path: Path) -> None:
    db_path = tmp_path / "trace_index.sqlite"
    traces_root = tmp_path / "traces"
    traces_root.mkdir(parents=True, exist_ok=True)
    seed_index(db_path)

    cmd = [
        sys.executable,
        str(OPTIMIZER),
        "--window",
        "50",
        "--db",
        str(db_path),
        "--traces-root",
        str(traces_root),
    ]

    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    payload = json.loads(result.stdout)
    assert payload["window"] == 50
    assert payload["trace_count"] == 3
    assert payload["report_path"] is None
    assert payload["proposal_path"] is None
