# Design: CIYA → AIYA Rename

## Problem Summary

The project name CIYA includes "C" referring to Claude Code. The project's purpose is broader than any single tool, so the name should reflect purpose (Agents In Your Area) rather than implementation.

## Approach

Global find-and-replace across all tracked files, plus rename the `.ciya/` directory to `.aiya/`. The rename is mechanical — no logic changes, only identifier/string changes.

Four categories of change:
1. **Directory**: `.ciya/` → `.aiya/` (physical rename + all references)
2. **Environment variables**: `CIYA_` prefix → `AIYA_` prefix
3. **tmux session name**: `ciya` default → `aiya`
4. **Project/repo references**: `ciya-dev` → `aiya-dev`, `ciya` → `aiya` in comments/docs

## Key Decisions

- **Rename the GitHub repository?** No — the repo URL is external infrastructure. The issue's AS1 says `grep -ri ciya` against tracked files returns zero matches, which means file contents only. The `AIYA_REPO_URL` default value will still point to `ciya-dev` repo until the repo itself is renamed (separate concern).
  - Update: Actually, to satisfy AS1 (zero matches for `grep -ri ciya`), all string occurrences in tracked files must be changed, including the default repo URL in `wc.sh` and the curl URL in README. These will point to `aiya-dev` even though the GitHub repo hasn't been renamed yet. This is intentional — the code anticipates the repo rename.
- **Work records content**: Historical work records (`.ciya/issues/00029/`, etc.) contain GitHub URLs with `ciya-dev`. These will be renamed to `.aiya/issues/` and their contents updated to `aiya-dev` to satisfy AS1.

## Open Questions

- None — the scope is clear from the AS.
