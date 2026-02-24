# Technical Writing Expert Review

## Scope

| File | Description |
|------|-------------|
| README.md | Updated project name from ciya-dev to aiya-dev, tagline, directory structure, URLs, environment variable references, tmux session name, and work records path |
| .env.example | Updated comment header from ciya-dev to aiya-dev, variable names from CIYA_ to AIYA_ |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | README.md heading, tagline, and all inline references consistently use "aiya-dev" / "aiya" / "AIYA_" — no missed ciya references found | N/A | No action needed |
| 2 | The setup URL in README.md line 148 references `https://raw.githubusercontent.com/lovaizu/aiya-dev/main/setup/wc.sh` — the GitHub repo is currently named `ciya-dev`, so this URL will 404 until the repo is renamed | Medium | Same as shell expert finding #2: this is correct for the target state after GitHub repo rename. No documentation change needed — the README should describe the final state. |
| 3 | The directory structure diagram (line 220) correctly shows `aiya-dev/` with `.aiya/` and `AIYA_*` prefix notation | N/A | No action needed |
| 4 | .env.example header comment correctly says "Environment variables for aiya-dev" and variables use AIYA_ prefix (AIYA_WORK_COUNT, AIYA_ALLOWED_DOMAINS_FILE) | N/A | No action needed |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 2 | Rejected | The README should describe the target state. The GitHub repo rename is a separate operational step — documenting the old name would create a second rename task for documentation. |
