## Problem Summary

After Gate 3 merge, `workflow.md` step 10 uses `git checkout --detach`, leaving the worktree in detached HEAD state. The developer must rely on `/hi` to create a new branch, but the `work-N` base branch is never explicitly updated to latest `origin/main`. This makes the worktree state less predictable.

## Approach

Two rule files need updating:

1. **`workflow.md` step 10 (Merge cleanup)** — Replace `git checkout --detach` with switching back to the `work-N` base branch and fast-forwarding it to `origin/main`. This ensures the worktree always has a named branch after merge.

2. **`hi.md` (Starting fresh)** — Before creating a task branch, explicitly switch to the `work-N` base branch and fast-forward it to `origin/main`. This ensures the developer always starts from the latest main, with the base branch visibly updated.

The base branch name is derived from the worktree directory: `basename "$(git rev-parse --show-toplevel)"`.

AS3 (fresh worktrees) is already satisfied by `up.sh` line 109.

## Key Decisions

- Use `git merge --ff-only origin/main` instead of `git reset --hard` — ff-only is non-destructive and will fail-safe if work-N has unexpected divergent commits, rather than silently discarding them.
- Detect the base branch name dynamically from the worktree directory name, since `up.sh` creates branches matching the directory name.

## Open Questions

None.
