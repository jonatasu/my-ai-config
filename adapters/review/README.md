# Review Adapter Boundary

The portable core requires independent review for non-trivial changes. A host
must map that requirement to an available reviewer, review service, or
provider-specific quality tool.

An adapter must document:

- how the current diff and acceptance evidence are supplied
- the reviewer capabilities and scope
- the structured result format
- how findings include file and line evidence
- how `PASS`, `REVIEW`, and `BLOCK` are distinguished
- how unavailable or silent reviewers are reported
- whether the review requires human approval

The adapter must not claim a positive verdict when the reviewer is unavailable,
returns no usable result, or evaluates stale evidence.
