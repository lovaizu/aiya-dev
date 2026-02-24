# Design: Project Rename to AIYA

## Problem Summary

The old project name included "C" referring to Claude Code. The project's purpose is broader than any single tool, so the name should reflect purpose (Agents In Your Area) rather than implementation.

## Approach

Global find-and-replace across all tracked files, plus rename the work records directory to `.aiya/`. The rename is mechanical — no logic changes, only identifier/string changes.

Four categories of change:
1. **Directory**: work records directory → `.aiya/` (physical rename + all references)
2. **Environment variables**: old prefix → `AIYA_` prefix
3. **tmux session name**: default → `aiya`
4. **Project/repo references**: `aiya-dev` in comments/docs

## Key Decisions

- **Rename the GitHub repository?** Developer renames the repo before merge so that the agent can verify the new URLs work. File contents are updated first, then the repo is renamed, then AS2/AS3 are verified.
- **Work records content**: Historical work records contain old GitHub URLs. These are updated to `aiya-dev` along with everything else.

## Open Questions

- None — the scope is clear from the AS.
