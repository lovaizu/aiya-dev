# Git Conventions

## Branch Strategy

- Create a branch from the latest `main`: `git fetch origin && git switch -c <branch-name> origin/main`
- Branch name describes the user's goal so team members understand the purpose at a glance. Use hyphen-separated words.
- Good: `parallel-claude-code-tasks`, `faster-test-feedback`
- Bad: `setup-bare-repo-worktree`, `refactor-module-to-class`

## Commit Conventions

- Split commits by purpose (one logical change per commit) so each commit tells a clear story in the log
- Commit title describes the purpose of the change
- Use relative paths or descriptive references in commit messages instead of absolute paths (starting with `/`) — absolute paths leak machine-specific information, and the sandbox hook enforces this
- Include `Co-Authored-By` in the commit body to indicate agent work:
  ```
  Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
  ```
