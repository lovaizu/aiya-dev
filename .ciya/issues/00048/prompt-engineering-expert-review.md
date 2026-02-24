# Prompt Engineering Expert Review

## Scope

| File | Description |
|------|-------------|
| `.claude/commands/hi.md` | Refactored to issue-creation only, no worktree detection |
| `.claude/commands/ok.md` | New command for implementation start/resume |
| `.claude/commands/ty.md` | State-based gate detection replacing worktree-based |
| `.claude/commands/bb.md` | Removed main/ worktree guard |
| `README.md` | Unified workflow documentation |
| `.claude/rules/workflow.md` | Removed worktree-specific phase annotations |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | `/hi.md` declares `$ARGUMENTS` but never uses it. Silent ignore of arguments. | Medium | Remove `$ARGUMENTS` declaration since `/hi` takes no arguments. |
| 2 | `/hi.md` has no error handling for `gh issue create` failure. | Medium | Add error scenario after step 5. |
| 3 | `/ty.md` has `disable-model-invocation: true` frontmatter. Expert suggests this prevents agent from executing Gates 2/3. | High | N/A — see decision. |
| 4 | `/ty.md` Gate 2 heuristic for "work-record commits" vs "implementation commits" is imprecise. | Medium | Check files changed: if all under `.ciya/`, work-record-only. If any outside `.ciya/`, implementation started. |
| 5 | `/ok.md` has no guidance for `git merge --ff-only` failure. | Medium | Add error handling: tell developer base branch diverged, suggest resolution. |
| 6 | `/ok.md` has only one example (fresh start). Resume and no-arguments paths have no examples. | Low | Add resume example with staleness detection. |
| 7 | `/bb.md` has no developer-interaction example. | Low | Add example block showing full `/bb` interaction. |
| 8 | `/ty.md` Gate 3 deletes `resume.md` without committing the deletion. | Medium | Remove deletion step — leave `resume.md` as historical record. |
| 9 | `/ok.md` only matches "Closes #N" — misses "Fixes #N", "Resolves #N". | Low | Our PR format specifies "Closes" — other keywords are not used. |
| 10 | All commands use "You are a..." persona opening. | Low | Replace with direct functional description. |
| 11 | `basename` assumption: worktree directory name must match branch name. | Low | Document assumption or add validation. |
| 12 | `/hi.md` step 7 says "Wait" — not actionable in agent context. | Low | Rephrase to describe what happens next. |
| 13 | `README.md` still labels main/ as "Issue management worktree" and work-N/ as "Implementation worktree" in directory structure. | Medium | Update labels to be worktree-neutral. |
| 14 | `README.md` up.sh comment says "plus 1 for issue management" implying main/ has a dedicated role. | Medium | Update comment to be worktree-neutral. |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 1 | Accepted | Undeclared parameter behavior is confusing. |
| 2 | Accepted | Error handling improves robustness. |
| 3 | Rejected | `disable-model-invocation: true` injects the command as system context — the agent still executes the instructions. This is correct behavior for `/ty` which needs context detection. |
| 4 | Accepted | Concrete heuristic prevents false gate detection. |
| 5 | Accepted | Real failure scenario that should be handled. |
| 6 | Rejected | Low value relative to added bulk. Single example covers the primary flow. |
| 7 | Rejected | The resume.md template is sufficient documentation of output format. |
| 8 | Accepted | Simpler and consistent with work-records rule ("version-controlled"). |
| 9 | Rejected | PR format specifies "Closes" consistently. |
| 10 | Rejected | Existing convention across all commands. |
| 11 | Rejected | Edge case; worktree naming convention is documented in setup. |
| 12 | Rejected | Agent interprets "wait" correctly in practice — it means "the next action comes from the developer." |
| 13 | Accepted | Labels contradict the unified workflow model. |
| 14 | Accepted | Comment contradicts the unified workflow model. |
