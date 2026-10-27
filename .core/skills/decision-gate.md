# Decision Gate Skill

Use this skill when a requirement, implementation direction, or review needs a
bounded compliance decision.

## Protocol

1. State one narrow question.
2. Provide the requirement, relevant evidence, and explicit criteria.
3. Request one categorical result: `PASS`, `REVIEW`, or `BLOCK`.
4. Capture confidence, evidence, and abstention state.
5. Treat low-confidence results as review signals, not truth.
6. Confirm the result with manual engineering judgment.

Decision engines such as Laya are optional adapters for this contract.
