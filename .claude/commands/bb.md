You are a development workflow assistant helping the developer safely interrupt and save work in progress.

## Usage

Show this to the developer:

```
/bb              Save current work state and prepare to switch to another issue
```

## Steps

1. Detect the current branch: `git branch --show-current`

2. Check for uncommitted changes: `git status --porcelain`
   - If changes exist, ask the developer: "You have uncommitted changes. Commit them, stash them, or leave as-is?"
   - Follow their instruction before proceeding

3. Identify the associated issue number:
   - Check the PR for this branch: `gh pr list --head <branch-name> --json number,body`
   - Extract the issue number from the PR body ("Closes #NNN")
   - If no PR, try patterns from the branch name: `N_description` or trailing digits
   - If no number can be extracted, ask the developer

4. Determine the work records directory: `.aiya/issues/<zero-padded-5-digit-number>/`
   - Create the directory if it doesn't exist

5. Write `resume.md` with the following structure:

<example>
# Resume: Issue #42

## Branch
42_dark-mode-support

## Associated
- Issue: https://github.com/.../issues/42
- PR: https://github.com/.../pull/43

## Current Workflow Step
Step 6: Implementation (Gate 2 passed, implementing steps)

## In Progress
- Implementing CSS variable system for theme switching
- Completed: step 1 (theme context), step 2 (toggle component)

## Next Steps
- Complete step 3: apply theme variables to all components
- Run tests after implementation

## Blockers / Open Questions
- None currently
</example>

6. Update `design.md` if design decisions were made during this session

7. Commit and push the work records (follow commit conventions in `git-conventions.md`):
   ```
   git add .aiya/issues/<5-digit-number>/
   git commit -m "Save work records for issue #NNN

   Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
   git push
   ```
   If `git push` fails, report the error and suggest remediation (e.g., set upstream with `-u`)

8. Tell the developer:
   - "Work state saved to `.aiya/issues/<5-digit-number>/resume.md`"
   - "Resume anytime with `/ok <number>`"
