import sqlite3
import json
import os
from pathlib import Path
from datetime import datetime

DB_PATH = Path("/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/harness/index/harness.db")
OUTPUT_PATH = Path("/Users/jonatas.vieira.ext/Github_repos/my-ai-config/.vault/harness/dashboard/index.html")

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI-Config Harness Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {{ font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; margin: 40px; background: #f5f5f7; color: #1d1d1f; }}
        .container {{ max-width: 1200px; margin: 0 auto; }}
        .header {{ display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }}
        .card {{ background: white; border-radius: 12px; padding: 24px; margin-bottom: 24px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }}
        .grid {{ display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }}
        table {{ width: 100%; border-collapse: collapse; margin-top: 20px; }}
        th, td {{ text-align: left; padding: 12px; border-bottom: 1px solid #eee; }}
        th {{ background: #fafafa; font-weight: 600; }}
        .metric-value {{ font-size: 24px; font-weight: bold; color: #0066cc; }}
        .timestamp {{ color: #86868b; font-size: 14px; }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>AI-Config Evolution Dashboard</h1>
            <div class="timestamp">Last updated: {timestamp}</div>
        </div>

        <div class="card">
            <h2>Overall Statistics</h2>
            <div class="metric-value">Total Traces Indexed: {total_traces}</div>
        </div>

        <div class="grid">
            <div class="card">
                <h2>Success Rate Over Time (%)</h2>
                <canvas id="successChart"></canvas>
            </div>
            <div class="card">
                <h2>Token Efficiency (Tokens/Success)</h2>
                <canvas id="efficiencyChart"></canvas>
            </div>
        </div>

        <div class="card">
            <h2>Latest Agent Metrics</h2>
            <table id="metricsTable">
                <thead>
                    <tr>
                        <th>Agent (Task Type)</th>
                        <th>Success Rate</th>
                        <th>Token Efficiency</th>
                        <th>Total Traces</th>
                    </tr>
                </thead>
                <tbody>
                    {table_rows}
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const successData = {success_data};
        const efficiencyData = {efficiency_data};

        function createChart(ctxId, data, label, color, yLabel) {{
            new Chart(document.getElementById(ctxId), {{
                type: 'line',
                data: {{
                    labels: data.labels,
                    datasets: data.datasets.map(ds => ({{
                        label: ds.agent,
                        data: ds.values,
                        borderColor: ds.color,
                        tension: 0.1
                    }}))
                }},
                options: {{
                    responsive: true,
                    scales: {{
                        y: {{ title: {{ display: true, text: yLabel }} }}
                    }}
                }}
            }});
        }}

        createChart('successChart', successData, 'Success Rate', '#0066cc', 'Percentage (%)');
        createChart('efficiencyChart', efficiencyData, 'Token Efficiency', '#ff9500', 'Tokens per Success');
    </script>
</body>
</html>
"""

def fetch_metrics():
    with sqlite3.connect(DB_PATH) as conn:
        # Total traces
        total_traces = conn.execute("SELECT count(*) FROM traces").fetchone()[0]
        
        # Agents (task_types)
        agents = [row[0] for row in conn.execute("SELECT DISTINCT task_type FROM traces WHERE task_type IS NOT NULL").fetchall()]
        
        # Since the DB doesn't have a sequence ID other than potentially trace_id, 
        # and we want time-series, we'll group by timestamp (date).
        # For a real dashboard, we'd probably use a window function or a separate aggregate table.
        
        success_series = {"labels": [], "datasets": []}
        efficiency_series = {"labels": [], "datasets": []}
        summary = []

        # Get unique dates
        dates = sorted([row[0] for row in conn.execute("SELECT DISTINCT date(timestamp) FROM traces WHERE timestamp IS NOT NULL").fetchall()])
        success_series["labels"] = dates

        colors = ["#0066cc", "#ff9500", "#34c759", "#af52de", "#ff3b30", "#5856d6"]

        for i, agent in enumerate(agents):
            color = colors[i % len(colors)]
            
            # Time series for success rate
            s_values = []
            e_values = []
            for date in dates:
                res = conn.execute(
                    "SELECT count(*), sum(case when outcome='success' then 1 else 0 end), sum(total_tokens) "
                    "FROM traces WHERE task_type=? AND date(timestamp)=?", (agent, date)
                ).fetchone()
                
                count, succ, tokens = res if res else (0, 0, 0)
                s_values.append((succ / count * 100) if count > 0 else 0)
                e_values.append((tokens / succ) if succ > 0 else 0)
            
            success_series["datasets"].append({"agent": agent, "values": s_values, "color": color})
            efficiency_series["datasets"].append({"agent": agent, "values": e_values, "color": color})

            # Latest summary
            res = conn.execute(
                "SELECT count(*), sum(case when outcome='success' then 1 else 0 end), sum(total_tokens) "
                "FROM traces WHERE task_type=?", (agent,)
            ).fetchone()
            count, succ, tokens = res if res else (0, 0, 0)
            rate = (succ / count * 100) if count > 0 else 0
            eff = (tokens / succ) if succ > 0 else 0
            summary.append((agent, f"{rate:.1f}%", f"{eff:.1f}", count))

        return total_traces, success_series, efficiency_series, summary

def generate():
    total, s_data, e_data, summary = fetch_metrics()
    
    table_rows = ""
    for agent, rate, eff, count in summary:
        table_rows += f"<tr><td>{agent}</td><td>{rate}</td><td>{eff}</td><td>{count}</td></tr>"
        
    html = HTML_TEMPLATE.format(
        timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        total_traces=total,
        table_rows=table_rows,
        success_data=json.dumps(s_data),
        efficiency_data=json.dumps(e_data)
    )
    
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(html)
    print(f"Dashboard generated at {OUTPUT_PATH}")

if __name__ == "__main__":
    generate()
