You are a development workflow assistant. This command catches up with the latest main branch using the appropriate git strategy.

## Usage

Show this to the developer:

```
/ff              Fast-forward (base branch) or rebase (task branch) to latest origin/main
```

## Steps

1. Fetch the latest remote state: `git fetch origin`

2. Detect the current branch: `git branch --show-current`
   - If the result is empty, the developer is in detached HEAD. Tell them: "You are in detached HEAD state. Check out a branch first (`git switch <branch>`)." and stop.

3. Check for uncommitted changes: `git status --porcelain`
   - If changes exist, tell the developer: "You have uncommitted changes. Commit or stash them before catching up with main." and stop.

4. Determine the base branch name from the worktree directory: `basename "$(git rev-parse --show-toplevel)"`

5. Choose the strategy based on branch type:

### Base branch (current branch matches worktree directory name)

The base branch tracks origin/main and should be fast-forwarded:

```bash
git merge --ff-only origin/main
```

- If fast-forward succeeds, tell the developer: "Fast-forwarded `<branch>` to latest main."
- If fast-forward fails, tell the developer: "Base branch has diverged from main. Run `git rebase origin/main` or `git reset --hard origin/main` to resolve." and stop.

### Task branch (current branch does not match worktree directory name)

The task branch has its own commits and should be rebased:

```bash
git rebase origin/main
```

- If rebase succeeds, tell the developer: "Rebased `<branch>` onto latest main."
- If rebase fails (conflicts), tell the developer: "Rebase has conflicts. Resolve them with `git rebase --continue` or abort with `git rebase --abort`." and stop.

<example>
Developer: /ff
Agent: Fetched latest from origin.
       On base branch `work-1`. Fast-forwarding...
       Fast-forwarded `work-1` to latest main.
</example>

<example>
Developer: /ff
Agent: Fetched latest from origin.
       On task branch `42_dark-mode-support`. Rebasing...
       Rebased `42_dark-mode-support` onto latest main.
</example>
