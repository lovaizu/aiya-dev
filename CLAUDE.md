# Project Rules

- **CLAUDE.md** — Repository-specific rules: domain knowledge, deliverables, project-specific conventions
- **`.claude/rules/`** — Reusable rules that are not repository-specific, split into one file per topic

## Environment Variables

- All environment variables defined by this project must use the `CIYA_` prefix (e.g., `CIYA_WORK_COUNT`, `CIYA_DEFAULT_BRANCH`)
- Third-party variables (e.g., `GH_TOKEN`, `ANTHROPIC_API_KEY`) keep their original names

## Temporary Files

- Use `.tmp/` at the repository root for temporary output (coverage reports, debug artifacts, helper scripts)
- `.tmp/` is in `.gitignore` — contents are ignored by Git
- Create subdirectories as needed (e.g., `.tmp/coverage/`, `.tmp/debug/`)
- Do not use the repository root or other tracked directories for temporary output
