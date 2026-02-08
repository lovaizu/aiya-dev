Detect the current branch and resume or start the workflow.

## If on main (or bare repo root)

Ask the developer what they want to work on, then follow the workflow from step 1 (Hearing).

## If on a feature branch

1. Identify the branch name and find the associated issue and PR using `gh`:
   - `gh pr list --head <branch-name> --json number,title,url`
   - If no PR exists, check `gh issue list` for a related issue
2. Read the full commit history on this branch: `git log origin/main..<branch-name> --oneline`
3. Determine which workflow step was last completed by checking:
   - Does an issue exist? (step 3+ done)
   - Does a PR exist? (step 5+ done)
   - Are there implementation commits? (step 7 in progress)
   - Does the PR body contain Expert Review / SC Check sections? (step 9+ done)
   - Are there pending review comments? (step 11 in progress)
4. Report the current status to the developer and resume the workflow from the next step
