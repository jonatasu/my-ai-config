# AI-Harness Operational Guide

This guide describes the optimization loop for agent configuration and behavior.

## The Optimization Loop: Observe $\rightarrow$ Propose $\rightarrow$ Test $\rightarrow$ Apply

### 1. Observe (Trace Collection)
Agents generate traces during execution. These are collected and indexed into the harness database.
- **Tool**: `trace_collector.py`
- **Action**: Index active traces to identify performance bottlenecks or failure patterns.

### 2. Propose (Meta-Optimization)
The `meta_optimizer.py` analyzes indexed traces and proposes changes to agent guidelines or tool configurations.
- **Command**: `python .tools/harness/scripts/meta_optimizer.py --emit-proposal --db trace_index.sqlite`
- **Output**: A JSON proposal containing a set of suggested changes based on failure analysis.

### 3. Test (A/B Evaluation)
Validate the proposal by running a set of benchmark tasks using both the baseline and the proposed configuration.
- **Command**: `bash .tools/harness/scripts/run_ab_eval.sh --proposal path/to/proposal.json`
- **Action**: Compare scores and outcomes to ensure the change is a genuine improvement.

### 4. Apply (Patching)
If the A/B test is successful, apply the patch to the production configuration.
- **Tool**: `apply_patch.py`
- **Action**: Merge the proposal changes into the active agent profiles.

## CLI Examples

### Scoring a Trace
```bash
python .tools/harness/scripts/score_trace.py --db trace_index.sqlite --trace-id trace-123 --outcome success --score 0.9
```

### Running Meta-Optimization
```bash
python .tools/harness/scripts/meta_optimizer.py --window 100 --db trace_index.sqlite --emit-report --emit-proposal
```
