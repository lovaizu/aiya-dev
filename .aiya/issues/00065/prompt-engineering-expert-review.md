# Prompt Engineering Expert Review

## Scope

| File | Description |
|------|-------------|
| .claude/commands/ff.md | New `/ff` command for catching up with latest main |
| .claude/commands/ja.md | New `/ja` command for switching to Japanese |
| .claude/commands/oi.md | New `/oi` command for turning discussions into issues |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | `/ff` does not check for uncommitted changes before rebasing. While git rebase refuses natively, `/bb` establishes a pattern of checking explicitly. Inconsistent error handling across commands confuses the agent. | Medium | Add a dirty working tree check before the git operation: run `git status --porcelain` and warn the developer if changes exist, suggesting they commit or stash first. |
| 2 | `/ff` does not handle detached HEAD state. `git branch --show-current` returns empty in detached HEAD, causing the branch comparison to behave unexpectedly (empty string never matches worktree name, so it would attempt a rebase). | Low | Add a guard: if `git branch --show-current` returns empty, tell the developer they are in detached HEAD and suggest checking out a branch first. |
| 3 | `/oi` steps instruct creating the issue directly but do not explicitly instruct showing the draft to the developer first. The example implies it, but agent behavior is more reliable when steps are explicit rather than inferred from examples. | Low | Add an explicit step between verify and create: "Show the verified draft to the developer." |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 1 | Accepted | Consistent with the `/bb` pattern; gives the developer a clear message before git refuses with a less helpful error |
| 2 | Accepted | Prevents confusing behavior in an edge case where the agent silently attempts rebase on a detached HEAD |
| 3 | Accepted | Makes behavior deterministic; follows the step-design rule that instructions should be explicit |
