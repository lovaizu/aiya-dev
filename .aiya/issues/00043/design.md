## Problem Summary

Branches and PR titles don't include issue numbers, so developers can't trace work without opening the PR or checking git history.

## Approach

Update two rule files:
1. `git-conventions.md` — Change branch naming format to `<issue number>_<hyphen-separated-goal>`
2. `pr-format.md` — Change PR title format to Title Case of goal part followed by `#<issue number>`

Both are documentation-only changes to existing rule files.

## Key Decisions

- Use underscore `_` to separate issue number from goal (keeps hyphens for word separation within the goal)
- PR title derives from branch name mechanically: replace hyphens with spaces, Title Case, append `#N`
- Examples are included in the rules for clarity

## Open Questions

None — scope is clear from the issue's SC1 and SC2.
