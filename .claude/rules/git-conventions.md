# Git Conventions

## Branch Strategy

- Create a branch from the latest `main`: `git fetch origin && git switch -c <issue number>_<hyphen-separated-goal> origin/main`
- Branch name format: `<issue number>_<hyphen-separated-goal>` (all lowercase)
  - Issue number: the GitHub issue number (no zero-padding)
  - Goal: the user's goal from the issue, not the implementation approach, using hyphen-separated words
- Good: `42_parallel-claude-code-tasks`, `15_faster-test-feedback`
- Bad: `42_setup-bare-repo-worktree`, `refactor-module-to-class`

## Commit Conventions

- Split commits by purpose (one logical change per commit)
- Commit title must describe the purpose of the change
- Do not include absolute paths (starting with `/`) in commit messages — the sandbox hook will block them
- Include `Co-Authored-By` in the commit body to indicate agent work:
  ```
  Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
  ```
