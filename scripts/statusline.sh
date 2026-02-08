#!/usr/bin/env bash
set -euo pipefail

input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir' | xargs basename)

branch=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git branch --show-current 2>/dev/null || echo "")
fi

model_id=$(echo "$input" | jq -r '.model.id // ""')
display_name=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
version=$(echo "$model_id" | sed -n 's/^claude-[a-z]*-\([0-9]\)-\([0-9]\).*/\1.\2/p')
if [ -n "$version" ]; then
  model="${display_name} ${version}"
else
  model="$display_name"
fi

token_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
token_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost_fmt=$(printf '$%.1f' "$cost")

ctx=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

echo "${dir} (${branch}) [${model}] [IN:${token_in} OUT:${token_out}] [${cost_fmt}] [ctx: ${ctx}%]"
