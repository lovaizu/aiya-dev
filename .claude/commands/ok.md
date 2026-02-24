You are a development workflow assistant. This command starts or resumes implementation work on a GitHub issue.

`$ARGUMENTS` is the text after the command name (e.g., in `/ok 42`, `$ARGUMENTS` is `42`). It may be empty.

## Usage

Show this to the developer:

```
/ok <number>     Start or resume work on an issue (accepts issue or PR number)
/ok              Show current branch status and available issues
```

## With `$ARGUMENTS` (issue or PR number)

Start or resume work on the specified issue:

1. **Resolve to issue number:** The developer may pass an issue number or a PR number. Resolve it:
   - Run `gh pr view $ARGUMENTS --json number,body` (suppress errors)
   - If it succeeds → `$ARGUMENTS` is a PR number. Extract the issue number from "Closes #N" in the body.
     - If "Closes #N" is not found, tell the developer: "PR #N has no linked issue (missing 'Closes #N' in body)." and stop.
   - If it fails → `$ARGUMENTS` is an issue number. Use it as-is.
2. Fetch the issue: `gh issue view <issue-number> --json number,title,url,body,state`
3. If the issue does not exist or `gh` returns an error, tell the developer and suggest checking the number or `gh` auth
4. If the issue is closed, tell the developer and ask if they want to reopen or work on a different issue
5. Check for work records: `.ciya/issues/` + zero-padded 5-digit issue number (e.g., `.ciya/issues/00029/`)
6. Check if a PR already exists for this issue: search PR bodies for "Closes #NNN" with `gh pr list --json number,title,url,headRefName,body`

### If resuming (work records exist or PR exists)

1. Read `resume.md` from the work records directory — it contains the workflow step and next actions
2. Read `design.md` if it exists
3. If a PR exists, read its current state
4. **Cross-reference for staleness:** Compare the workflow step in `resume.md` against the actual PR/branch state:
   - Check `git log origin/main..HEAD --oneline` for implementation commits
   - Check the PR's review state (`reviewDecision`) and review comments
   - If `resume.md` says "step 6" but implementation commits exist, the actual state is ahead — advance to the appropriate step
   - If `resume.md` references files or decisions that no longer exist on the branch, note the discrepancies
   - Report any staleness detected: "resume.md says X, but actual state is Y. Advancing to step Z."
5. Report the current status to the developer
6. Resume from the **actual** workflow step (which may differ from what `resume.md` says if staleness was detected)

### If starting fresh

1. Determine the base branch name from the worktree directory: `basename "$(git rev-parse --show-toplevel)"`
2. Update the base branch to latest main: `git fetch origin && git switch <base-branch> && git merge --ff-only origin/main` — ensures the developer always starts from the latest main
   - If `git merge --ff-only` fails, tell the developer: "Base branch has diverged from main. Run `git rebase origin/main` or `git reset --hard origin/main` to resolve." and stop.
3. Create a task branch from the updated base: `git switch -c <branch-name>`
   - Branch name: `<issue-number>_<hyphen-separated-goal>` derived from the issue goal (see `git-conventions.md`)
4. Create the work records directory: `.ciya/issues/<5-digit-number>/`
5. Create `design.md` with: `## Problem Summary`, `## Approach`, `## Key Decisions`, `## Open Questions`
6. Proceed to PR description drafting (workflow step 4):
   - Draft PR title and body with Approach and Steps (see `pr-format.md`)
   - Create the PR on GitHub: `gh pr create`
   - Tell the developer: "PR created. Review on GitHub, then `/ty` to approve the approach."

<example>
Developer: /ok 42
Agent: Found Issue #42: "As a user, I want dark mode..."
       No existing work records. Starting fresh.
       Created branch: 42_dark-mode-support
       Created work records at .ciya/issues/00042/
       Here's the PR draft: [shows approach and steps]
       PR created: https://github.com/.../pull/43
       Review on GitHub, then `/ty` to approve the approach.
</example>

## Without arguments

1. Show the current branch and any associated issue/PR
2. List recent open issues: `gh issue list --limit 5`
3. Tell the developer: "Run `/ok <number>` to start or resume work (accepts issue or PR number)"
