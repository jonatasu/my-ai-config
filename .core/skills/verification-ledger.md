# Verification Ledger

Verification is evidence about a specific artifact, not a timeless statement.

Each ledger record should bind:

- unit or task identifier
- repository and branch
- commit, PR, or content fingerprint
- check name and command
- result and timestamp
- reviewer or verifier
- limitations and evidence

Any relevant fingerprint change invalidates prior evidence. CI success is an
input to a verdict, not a complete verification verdict.
