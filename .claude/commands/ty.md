---
disable-model-invocation: true
---

You are a development workflow assistant managing approval gates and workflow progression.

The developer has approved. Detect which gate this is and proceed.

## Usage

Show this to the developer:

```
/ty              Approve the current gate
```

## Three Gates

- **Gate 1 — Goal:** Is the issue capturing the right problem and goal?
- **Gate 2 — Approach:** Can the PR's approach achieve the goal?
- **Gate 3 — Goal Verification:** Has the goal been achieved?

## Detect the gate

Use this decision tree:

1. Find a PR for the current branch: `gh pr list --head $(git branch --show-current) --json number,title,body,url,reviewDecision`
2. If no PR exists → **Gate 1**
3. If a PR exists:
   a. Check which files have changed: `git diff --name-only origin/main..HEAD`
   b. If no changed files, or all changed files are under `.aiya/` → **Gate 2**
   c. If any changed files are outside `.aiya/` → **Gate 3**

If the gate cannot be determined, tell the developer which gate could not be identified and ask them to clarify.

## Gate 1: Goal (no PR exists)

The developer approved the issue.

1. Tell the developer: "Issue approved. Run `/ok <number>` to start implementation."

<example>
Developer: /ty
Agent: Gate 1 — Goal approved.
       Run `/ok 42` to start implementation.
</example>

## Gate 2: Approach (PR exists, no implementation yet)

The developer approved the PR approach. Proceed to implementation:

1. Follow the workflow steps in `workflow.md` starting from step 6 (Implementation):
   - Implement the solution following the PR tasks
   - Make commits (split by purpose, one logical change per commit)
   - Push commits to the remote branch
2. After implementation, continue through steps 7-9:
   - Consistency check, expert review, scenario evaluation
3. Tell the developer: "Implementation complete. Review on GitHub, then `/ty` to approve."

<example>
Developer: /ty
Agent: Gate 2 — Approach approved. Starting implementation.
       [implements, commits, pushes, runs checks]
       Implementation complete. Review on GitHub, then `/ty` to approve.
</example>

## Gate 3: Goal Verification (PR with implementation)

The developer confirmed the goal is achieved. Proceed to merge:

1. Verify approval: `gh pr view <number> --json reviewDecision` must return `APPROVED`
2. If not `APPROVED`, tell the developer: "Please approve the PR on GitHub first, then run `/ty` again."
3. Squash merge: `gh pr merge <number> --squash`
4. Determine the base branch name from the worktree directory: `basename "$(git rev-parse --show-toplevel)"`
5. Return to base branch and update: `git switch <base-branch> && git fetch origin && git merge --ff-only origin/main`
6. Delete task branch: `git push origin --delete <branch-name> && git branch -D <branch-name>`
7. Tell the developer: "Merged! Ready for the next `/ok <number>`."

<example>
Developer: /ty
Agent: Gate 3 — Goal verification approved.
       PR #43 is approved. Merging...
       Merged! Ready for the next `/ok <number>`.
</example>
