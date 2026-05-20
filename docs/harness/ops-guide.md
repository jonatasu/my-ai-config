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


## 🚀 Autonomous Mode

The `harness-autopilot` provides a fully autonomous optimization cycle. It monitors the harness database and triggers an optimization loop when performance degrades or enough new data is available.

### How it Works
The autopilot runs as a background daemon that periodically checks two trigger conditions:
1. **New Traces**: Triggered when the number of unprocessed traces exceeds `NEW_TRACES_THRESHOLD` (default: 100).
2. **Quality Drop**: Triggered when the success rate of the last 50 traces falls below `SUCCESS_THRESHOLD` (default: 80%).

### The GitOps Flow
When triggered, the autopilot executes the following sequence:
**Proposal** $\rightarrow$ **Evaluation** $\rightarrow$ **Patch** $\rightarrow$ **Push**

1. **Proposal**: Runs `meta_optimizer.py` to generate a configuration proposal based on failure analysis.
2. **Evaluation**: Executes `run_ab_eval.sh` to verify that the proposal improves performance against the baseline.
3. **Patch**: Applies the validated changes using `apply_patch.py`.
4. **Push**: Uses `git_proposal.py` to commit and push the changes to the remote repository for merge.

### Visual Dashboard
The result of every autonomous cycle is reflected in the visual dashboard located at `.vault/harness/dashboard/index.html`.
- **Current Health**: Real-time view of success rates and scoring.
- **Optimization History**: Logs of previous proposals and their A/B test results.
- **Active Patches**: Highlights which configurations are currently under evaluation or applied.

