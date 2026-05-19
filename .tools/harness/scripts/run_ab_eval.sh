#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  run_ab_eval.sh --baseline <baseline_config.yaml> --candidate <candidate_config.yaml> --suite <prompts.txt> --out <report.json> [--min-samples N] [--token-improvement-threshold F]

Environment:
  AB_EVAL_SIMULATE=1      Run deterministic simulation instead of live calls
  AB_EVAL_REPORTER=<path> Override reporter script path
EOF
}

BASELINE=""
CANDIDATE=""
SUITE=""
OUT=""
MIN_SAMPLES="30"
TOKEN_THRESHOLD="0.1"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --baseline) BASELINE="$2"; shift 2 ;;
    --candidate) CANDIDATE="$2"; shift 2 ;;
    --suite) SUITE="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    --min-samples) MIN_SAMPLES="$2"; shift 2 ;;
    --token-improvement-threshold) TOKEN_THRESHOLD="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 1 ;;
  esac
done

if [[ -z "$BASELINE" || -z "$CANDIDATE" || -z "$SUITE" || -z "$OUT" ]]; then
  echo "Missing required arguments" >&2
  usage >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORTER="${AB_EVAL_REPORTER:-$SCRIPT_DIR/ab_eval_report.py}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

BASELINE_JSON="$TMP_DIR/baseline_results.json"
CANDIDATE_JSON="$TMP_DIR/candidate_results.json"

if [[ "${AB_EVAL_SIMULATE:-0}" == "1" ]]; then
  python3 - "$SUITE" "$BASELINE_JSON" "$CANDIDATE_JSON" <<'PY'
import json
import sys
from pathlib import Path

suite_path = Path(sys.argv[1])
baseline_path = Path(sys.argv[2])
candidate_path = Path(sys.argv[3])
prompts = [line.strip() for line in suite_path.read_text(encoding='utf-8').splitlines() if line.strip()]

baseline_rows = []
candidate_rows = []
for i, prompt in enumerate(prompts):
    baseline_rows.append({
        "prompt": prompt,
        "success": (i % 2 == 0),
        "total_tokens": 110 if i % 2 == 0 else 140,
        "latency_ms": 220 + i,
    })
    candidate_rows.append({
        "prompt": prompt,
        "success": True,
        "total_tokens": 80,
        "latency_ms": 180 + i,
    })

baseline_path.write_text(json.dumps({"results": baseline_rows}, ensure_ascii=True), encoding='utf-8')
candidate_path.write_text(json.dumps({"results": candidate_rows}, ensure_ascii=True), encoding='utf-8')
PY
else
  echo "Live mode is not implemented yet. Use AB_EVAL_SIMULATE=1 for now." >&2
  exit 1
fi

python3 "$REPORTER" \
  --baseline-results "$BASELINE_JSON" \
  --candidate-results "$CANDIDATE_JSON" \
  --out "$OUT" \
  --min-samples "$MIN_SAMPLES" \
  --token-improvement-threshold "$TOKEN_THRESHOLD"

echo "A/B report written to: $OUT"
