The developer has approved. Detect which approval gate this is and proceed.

1. Find the PR for the current branch: `gh pr list --head <branch-name> --json number,title,body,url`
2. Determine the current approval gate:

## Gate: Issue approved (no PR exists yet)

Proceed to step 5 of the workflow: draft the PR title and body, and present it to the developer.

## Gate: PR description approved (PR not yet created)

Proceed to step 7 of the workflow: implement the solution, make commits, push the branch, and create the PR with `gh pr create`. Then continue through consistency check, expert review, and success criteria check.

## Gate: PR approved (PR exists and is approved)

Proceed to step 13 of the workflow:
1. Verify approval: `gh pr view <number> --json reviewDecision` must return `APPROVED`
2. Squash merge: `gh pr merge <number> --squash`
3. Remove the worktree: `git worktree remove <branch-name>`
4. Delete the local branch: `git branch -d <branch-name>`
5. Prune remote tracking branches: `git fetch --prune`
6. Report completion
