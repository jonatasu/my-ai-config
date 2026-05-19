from __future__ import annotations

import json
import sqlite3
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INDEXER = ROOT / ".tools" / "harness" / "scripts" / "trace_indexer.py"
SCORER = ROOT / ".tools" / "harness" / "scripts" / "score_trace.py"

def index_trace(db_path: Path, trace_id: str = "trace-score-1") -> None:
    trace_file = db_path.parent / f"{trace_id}.json"
    payload = {
        "trace_id": trace_id,
        "timestamp": "2026-05-19T12:00:00Z",
        "session_id": "sess-score",
        "query": "hello",
        "task_type": "review",
        "usage": {"total_tokens": 100},
        "final_answer": "ok",
        "outcome": None,
        "score": None,
    }
    trace_file.write_text(json.dumps(payload), encoding="utf-8")
    subprocess.run(
        [
            sys.executable,
            str(INDEXER),
            "index",
            "--trace-file",
            str(trace_file),
            "--db",
            str(db_path),
        ],
        check=True,
    )

def fetch_score_row(db_path: Path, trace_id: str) -> tuple[str | None, float | None]:
    conn = sqlite3.connect(db_path)
    try:
        row = conn.execute(
            "SELECT outcome, score FROM traces WHERE trace_id = ?",
            (trace_id,),
        ).fetchone()
    finally:
        conn.close()
    assert row is not None
    return row

def test_score_trace_updates_outcome_and_score(tmp_path: Path) -> None:
    db_path = tmp_path / "trace_index.sqlite"
    trace_id = "trace-score-1"
    index_trace(db_path, trace_id)

    subprocess.run(
        [
            sys.executable,
            str(SCORER),
            "--db",
            str(db_path),
            "--trace-id",
            trace_id,
            "--outcome",
            "success",
            "--score",
            "0.82",
        ],
        check=True,
    )

    outcome, score = fetch_score_row(db_path, trace_id)
    assert outcome == "success"
    assert score == 0.82

def test_score_trace_fails_for_missing_trace_id(tmp_path: Path) -> None:
    db_path = tmp_path / "trace_index.sqlite"
    index_trace(db_path, "existing-trace")

    result = subprocess.run(
        [
            sys.executable,
            str(SCORER),
            "--db",
            str(db_path),
            "--trace-id",
            "missing-trace",
            "--outcome",
            "failure",
        ],
        capture_output=True,
        text=True,
    )

    assert result.returncode != 0
    assert "missing-trace" in result.stderr
