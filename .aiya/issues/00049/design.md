## Problem Summary

Agents generate temporary files (coverage output, debug artifacts) directly in the repository root. Without a convention and `.gitignore` entry, these files clutter `git status` and risk accidental commits.

## Approach

Establish a `.tmp/` directory convention at the repository root:
1. Add `.tmp/` to `.gitignore` so Git ignores everything under it
2. Add a rule in CLAUDE.md documenting the convention for agents and developers
3. Both SCs share the same approach — a single `.gitignore` entry + rule covers both "not in `git status`" and "not staged by `git add -A`"

## Key Decisions

- **`.tmp/` over `.cache/` or `tmp/`**: `.tmp/` uses the dot-prefix convention (hidden, project-local), mirrors `.env`/`.ciya` patterns in this repo. `tmp/` is too generic and may conflict with other tools.
- **Repo-root `.tmp/` over `/tmp`**: Issue explicitly states `/tmp` is unsuitable because OS cleans it on reboot and debug artifacts need to persist across sessions.
- **No subdirectory structure enforced**: Let agents and developers create whatever subdirectories they need (e.g., `.tmp/coverage/`, `.tmp/debug/`). Over-specifying structure adds friction without benefit.

## Open Questions

None.
