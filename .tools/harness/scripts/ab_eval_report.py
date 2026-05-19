#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
from pathlib import Path
from statistics import median


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Compute A/B harness evaluation metrics and gate decision.")
    parser.add_argument("--baseline-results", required=True, help="Path to baseline results JSON.")
    parser.add_argument("--candidate-results", required=True, help="Path to candidate results JSON.")
    parser.add_argument("--out", required=True, help="Path to write consolidated report JSON.")
    parser.add_argument("--min-samples", type=int, default=30, help="Minimum samples required per arm.")
    parser.add_argument(
        "--token-improvement-threshold",
        type=float,
        default=0.1,
        help="Required fractional improvement for tokens_per_success (0.1 = 10%%).",
    )
    return parser.parse_args()


def load_results(path: Path) -> list[dict]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    results = payload.get("results", [])
    if not isinstance(results, list):
        raise ValueError(f"Invalid results format in {path}: 'results' must be an array")
    return results


def compute_metrics(rows: list[dict]) -> dict:
    sample_size = len(rows)
    successes = [r for r in rows if bool(r.get("success"))]
    failures = sample_size - len(successes)
    success_rate = (len(successes) / sample_size) if sample_size else 0.0

    success_tokens = [int(r.get("total_tokens", 0)) for r in successes]
    tokens_per_success = (sum(success_tokens) / len(success_tokens)) if success_tokens else float("inf")

    latencies = [int(r.get("latency_ms", 0)) for r in rows]
    p50_latency_ms = int(median(latencies)) if latencies else 0

    return {
        "sample_size": sample_size,
        "success_count": len(successes),
        "failure_count": failures,
        "success_rate": success_rate,
        "tokens_per_success": tokens_per_success,
        "p50_latency_ms": p50_latency_ms,
    }


def gate_decision(baseline: dict, candidate: dict, min_samples: int, threshold: float) -> tuple[dict, str]:
    sample_size_ok = baseline["sample_size"] >= min_samples and candidate["sample_size"] >= min_samples
    success_non_regression = candidate["success_rate"] >= baseline["success_rate"]

    base_tps = baseline["tokens_per_success"]
    cand_tps = candidate["tokens_per_success"]
    if base_tps == float("inf"):
        token_improvement = cand_tps < float("inf")
    else:
        token_improvement = cand_tps <= base_tps * (1.0 - threshold)

    gate = {
        "sample_size_ok": sample_size_ok,
        "success_non_regression": success_non_regression,
        "token_improvement": token_improvement,
    }
    decision = "promote" if all(gate.values()) else "reject"
    return gate, decision


def main() -> int:
    args = parse_args()
    baseline_rows = load_results(Path(args.baseline_results))
    candidate_rows = load_results(Path(args.candidate_results))

    baseline_metrics = compute_metrics(baseline_rows)
    candidate_metrics = compute_metrics(candidate_rows)
    gate, decision = gate_decision(
        baseline_metrics,
        candidate_metrics,
        min_samples=args.min_samples,
        threshold=args.token_improvement_threshold,
    )

    report = {
        "baseline": baseline_metrics,
        "candidate": candidate_metrics,
        "gate": gate,
        "decision": decision,
    }

    out_path = Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(report, indent=2, ensure_ascii=True) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
