#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Any

REDACTED = "[REDACTED]"
PATTERNS = [
    re.compile(r"(?i)(authorization\s*:\s*bearer\s+)[^\s\"]+"),
    re.compile(r"(?i)(api[_-]?key\s*[=:]\s*)[^\s\"]+"),
    re.compile(r"(?i)(token\s*[=:]\s*)[^\s\"]+"),
    re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"),
    re.compile(r"\bsk-[A-Za-z0-9-]{8,}\b"),
]

def redact_string(value: str) -> str:
    result = value
    for pattern in PATTERNS:
        if pattern.groups:
            result = pattern.sub(lambda m: f"{m.group(1)}{REDACTED}", result)
        else:
            result = pattern.sub(REDACTED, result)
    return result

def redact_value(value: Any) -> Any:
    if isinstance(value, str):
        return redact_string(value)
    if isinstance(value, list):
        return [redact_value(item) for item in value]
    if isinstance(value, dict):
        return {k: redact_value(v) for k, v in value.items()}
    return value

def main() -> int:
    parser = argparse.ArgumentParser(description="Generic Trace Redactor")
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", help="Output path. If omitted, prints to stdout.")
    
    args = parser.parse_args()
    in_path = Path(args.input)
    
    payload = json.loads(in_path.read_text(encoding="utf-8"))
    redacted = redact_value(payload)
    
    output_json = json.dumps(redacted, indent=2)
    if args.output:
        Path(args.output).write_text(output_json + "\n", encoding="utf-8")
    else:
        print(output_json)
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main())
