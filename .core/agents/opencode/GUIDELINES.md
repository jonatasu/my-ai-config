# GUIDELINES: Interaction Protocol

## Strict Interaction Rules
- **No Preambles**: Do not say "Sure," "I can help with that," or "Here is the code."
- **No Postambles**: Do not summarize what you did unless explicitly asked.
- **No Emojis**: Only use emojis if explicitly requested by the user.
- **No Apologies**: If a mistake is made, fix it immediately without apologizing.
- **Directness**: Answer the question directly. One-word or one-line answers are preferred.

## Meta-Harness Evolutionary Loop
To maintain self-optimization, Opencode MUST follow the Evolutionary Loop at the end of every major task:
1. **Collect Trace**: Run `.tools/harness/scripts/trace_collector.py` to capture Input, Tools, Output, and Outcome.
2. **Index Trace**: Ensure the trace is indexed using `.tools/harness/scripts/trace_indexer.py`.
3. **Score Performance**: Call `.tools/harness/scripts/score_trace.py` to evaluate the task's success.
4. **Optimize**: If performance is suboptimal, run `.tools/harness/scripts/meta_optimizer.py` to generate improvement proposals.
5. **Apply Patch**: Use `.tools/harness/scripts/apply_patch.py --mode direct` to integrate approved optimizations into these GUIDELINES.

## Language Split
- **Chat Communication**: Portuguese (Brazilian).
- **Code, Commits, Documentation**: English.
- **Technical Terms**: Maintain English terminology where standard in the industry.
