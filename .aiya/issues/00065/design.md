## Problem Summary

The developer repeatedly types the same instructions for three frequent operations: catching up with latest main (different commands depending on branch type), switching conversation to Japanese, and turning a discussion into a GitHub issue. These operations should be one-command shortcuts.

## Approach

Create three new slash commands as `.claude/commands/*.md` files following the existing command pattern:

1. **`/ff`** — Fast-forward or rebase to latest main, detecting branch type automatically
   - Base branch (matches worktree directory name): `git fetch origin && git merge --ff-only origin/main`
   - Task branch (any other branch): `git fetch origin && git rebase origin/main`

2. **`/ja`** — Switch to Japanese with re-explanation
   - Re-explain the previous response in Japanese
   - Continue the conversation in Japanese going forward

3. **`/oi`** — Turn the current discussion into a structured issue
   - Extract goal, scope, and user context from the conversation history
   - Draft issue following `requirements-definition.md` and `issue-format.md`
   - Create the issue on GitHub with `gh issue create`

## Key Decisions

- `/ff` detects branch type by comparing `git branch --show-current` against `basename "$(git rev-parse --show-toplevel)"` (the worktree directory name). This reuses the same convention used by `/ok` and `/ty`.
- `/ja` uses `disable-model-invocation: true` frontmatter since it needs to act on the conversation context directly, similar to `/ty`.
- `/oi` reuses the hearing procedure from `requirements-definition.md` but skips the initial "ask the developer" step since the discussion has already happened. It extracts requirements from conversation history instead.

## Open Questions

- None currently.
