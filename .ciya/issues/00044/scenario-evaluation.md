# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | OK | Inspected | Cannot execute because merge cleanup requires an actual squash-merge to have occurred. Inspected workflow.md step 10 and ty.md Gate 3 step 4: both now use `git switch <work-N>` instead of `git checkout --detach`, leaving the worktree on a named branch. As a developer, after Gate 3 merge, `git branch` would show `work-N` (not detached HEAD). Then is satisfied. |
| AS2 | OK | Inspected | Cannot execute because starting fresh requires a real issue to branch from. Inspected hi.md "starting fresh" step 1: it runs `git fetch origin && git switch <work-N> && git merge --ff-only origin/main` before creating the task branch. As a developer, when creating a task branch, it is created from `work-N` which has been fast-forwarded to the latest `origin/main`. Then is satisfied. |
| AS3 | OK | Inspected | Cannot execute because worktree creation requires the bare repo structure. Inspected up.sh line 109: `git worktree add "$name" -b "$name" "origin/$CIYA_DEFAULT_BRANCH"` creates a named `work-N` branch. As a developer, checking a fresh worktree shows a named `work-N` branch. Then is satisfied. |
