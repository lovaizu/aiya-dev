## Problem Summary

`up.sh` creates a tmux session named `aiya` but there is no symmetric script to tear it down. Developers must manually remember the session name and run `tmux kill-session -t aiya`.

## Approach

Create `setup/dn.sh` as the counterpart to `setup/up.sh`. It kills the `aiya` tmux session. When no session exists, it exits gracefully with a message instead of failing.

Follow the same patterns as `up.sh`:
- Same `REPO_ROOT` auto-detection guard with `LCOV_EXCL` (for direct execution)
- `SESSION_NAME` overridable via environment variable (for testing)
- Sourceable for unit testing (functions + `BASH_SOURCE` guard)

## Key Decisions

- Mirror `up.sh` structure: auto-detect block, overridable `SESSION_NAME`, sourceable functions
- Use `tmux has-session` to check existence before `kill-session` to provide a clean message
- Keep it minimal — no config cleanup, no worktree removal (those are separate concerns)

## Open Questions

None.
