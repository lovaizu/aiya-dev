# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | OK | Executed | As a developer, ran `git switch work-1 && git fetch origin && git merge --ff-only origin/main` from the task branch. Ran `git branch --show-current`. Got `work-1`. The worktree is on a named branch (not detached HEAD). Then is satisfied. |
| AS2 | OK | Executed | As a developer, after fast-forwarding work-1 to origin/main, ran `git switch -c test-as2-branch`. Compared HEAD with `origin/main`: both at commit `2cb2528`. The task branch is created from the latest `origin/main`. Then is satisfied. |
| AS3 | OK | Executed | As a developer, ran `git branch --list 'work-*'`. Got `work-1` through `work-7`, all named branches. The worktree has a named `work-N` branch. Then is satisfied. |
