#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sqlite3
import time
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Index normalized trace files into SQLite.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    index = subparsers.add_parser("index", help="Insert or update one trace record.")
    index.add_argument("--trace-file", required=True, help="Path to normalized trace JSON.")
    index.add_argument("--db", default="/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/harness/index/harness.db", help="SQLite database path.")
    index.add_argument("--max-retries", type=int, default=5, help="Retries on database lock.")
    index.add_argument("--retry-delay-ms", type=int, default=100, help="Base retry delay in ms.")

    scan = subparsers.add_parser("scan", help="Scan logs directory and index all traces.")
    scan.add_argument("--logs-dir", default="/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/logs", help="Logs directory to scan.")
    scan.add_argument("--db", default="/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/harness/index/harness.db", help="SQLite database path.")

    return parser.parse_args()


def ensure_schema(conn: sqlite3.Connection) -> None:
    conn.execute("PRAGMA journal_mode=WAL;")
    conn.execute("PRAGMA synchronous=NORMAL;")
    conn.execute(
        """
        CREATE TABLE IF NOT EXISTS traces (
            trace_id TEXT PRIMARY KEY,
            timestamp TEXT NOT NULL,
            session_id TEXT NOT NULL,
            task_type TEXT,
            total_tokens INTEGER,
            outcome TEXT,
            score REAL,
            query TEXT,
            final_answer TEXT,
            trace_path TEXT NOT NULL,
            indexed_at TEXT NOT NULL
        )
        """
    )
    conn.execute("CREATE INDEX IF NOT EXISTS idx_traces_timestamp ON traces(timestamp)")
    conn.execute("CREATE INDEX IF NOT EXISTS idx_traces_task_type ON traces(task_type)")


def read_trace(trace_file: Path) -> dict:
    payload = json.loads(trace_file.read_text(encoding="utf-8"))
    required = ["trace_id", "timestamp", "session_id", "query", "final_answer"]
    missing = [key for key in required if key not in payload]
    if missing:
        raise ValueError(f"Trace missing required keys: {', '.join(missing)}")
    return payload


def upsert_trace(conn: sqlite3.Connection, trace: dict, trace_path: Path) -> None:
    usage = trace.get("usage") or {}
    conn.execute(
        """
        INSERT INTO traces (
            trace_id,
            timestamp,
            session_id,
            task_type,
            total_tokens,
            outcome,
            score,
            query,
            final_answer,
            trace_path,
            indexed_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
        ON CONFLICT(trace_id) DO UPDATE SET
            timestamp=excluded.timestamp,
            session_id=excluded.session_id,
            task_type=excluded.task_type,
            total_tokens=excluded.total_tokens,
            outcome=excluded.outcome,
            score=excluded.score,
            query=excluded.query,
            final_answer=excluded.final_answer,
            trace_path=excluded.trace_path,
            indexed_at=excluded.indexed_at
        """,
        (
            trace.get("trace_id"),
            trace.get("timestamp"),
            trace.get("session_id"),
            trace.get("task_type"),
            usage.get("total_tokens"),
            trace.get("outcome"),
            trace.get("score"),
            trace.get("query"),
            trace.get("final_answer"),
            str(trace_path),
        ),
    )


def connect_with_retry(db_path: Path, max_retries: int, retry_delay_ms: int) -> sqlite3.Connection:
    attempt = 0
    while True:
        try:
            conn = sqlite3.connect(db_path)
            return conn
        except sqlite3.OperationalError as exc:
            attempt += 1
            if "locked" not in str(exc).lower() or attempt > max_retries:
                raise
            time.sleep((retry_delay_ms * attempt) / 1000)


def execute_with_retry(
    conn: sqlite3.Connection,
    fn,
    *,
    max_retries: int,
    retry_delay_ms: int,
) -> None:
    attempt = 0
    while True:
        try:
            fn()
            return
        except sqlite3.OperationalError as exc:
            attempt += 1
            if "locked" not in str(exc).lower() or attempt > max_retries:
                raise
            time.sleep((retry_delay_ms * attempt) / 1000)


def run_index(trace_file: Path, db_path: Path, max_retries: int, retry_delay_ms: int) -> int:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        trace = read_trace(trace_file)
    except Exception as e:
        print(f"Error reading {trace_file}: {e}")
        return 1

    conn = connect_with_retry(db_path, max_retries=max_retries, retry_delay_ms=retry_delay_ms)
    try:
        ensure_schema(conn)

        def _tx() -> None:
            upsert_trace(conn, trace, trace_file.resolve())
            conn.commit()

        execute_with_retry(
            conn,
            _tx,
            max_retries=max_retries,
            retry_delay_ms=retry_delay_ms,
        )
    finally:
        conn.close()

    print(trace.get("trace_id"))
    return 0


def run_scan(logs_dir: Path, db_path: Path) -> int:
    if not logs_dir.exists():
        print(f"Logs directory {logs_dir} does not exist.")
        return 1
    
    traces_found = 0
    for trace_file in logs_dir.rglob("*.json"):
        if run_index(trace_file, db_path, 5, 100) == 0:
            traces_found += 1
    
    print(f"Indexed {traces_found} traces from {logs_dir}")
    return 0


def main() -> int:
    args = parse_args()

    if args.command == "index":
        return run_index(
            trace_file=Path(args.trace_file),
            db_path=Path(args.db),
            max_retries=args.max_retries,
            retry_delay_ms=args.retry_delay_ms,
        )
    
    if args.command == "scan":
        return run_scan(
            logs_dir=Path(args.logs_dir),
            db_path=Path(args.db),
        )

    raise SystemExit(f"Unsupported command: {args.command}")


if __name__ == "__main__":
    raise SystemExit(main())
