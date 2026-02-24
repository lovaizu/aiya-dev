# Design: Unified Workflow Regardless of Worktree

## Problem Summary

`/hi` currently behaves differently in main/ vs work-N/ worktrees — issue creation in main/, implementation start in work-N/. This forces developers to know which worktree they're in and prevents creating issues as backlog items without being pushed into implementation.

## Approach

Split `/hi` into two single-responsibility commands:
- `/hi` — always creates issues, in any worktree
- `/ok` — always starts/resumes implementation, in any worktree

Remove all worktree-type detection (`basename "$(git rev-parse --show-toplevel)"`) from commands that no longer need it.

Update `/ty` to detect gates without relying on worktree type — use PR existence and commit history instead.

Update `/bb` to work in any worktree (remove main/ guard).

Update README to show a unified workflow with no main/ vs work-N/ separation.

## Key Decisions

1. **`/ok` name** — Short, memorable, follows the existing pattern of two-letter commands (`/hi`, `/ty`, `/fb`, `/bb`). Means "let's go" — signals readiness to start work.

2. **Gate detection in `/ty`** — Currently uses worktree type for Gate 1 vs Gate 2/3. New approach: detect Gate 1 when no PR exists for any issue in the conversation context, Gate 2 when a PR exists but has no implementation commits, Gate 3 when implementation commits exist. The gate detection becomes purely state-based rather than location-based.

3. **`/bb` in any worktree** — Currently refuses to run in main/. Since `/ok` can now start implementation in any worktree, `/bb` should also save state in any worktree.

4. **`workflow.md` updates** — Remove worktree-specific annotations from phases. The phases still exist (Goal → Approach → Delivery) but are no longer tied to specific worktrees.

## Open Questions

None — the issue and its AS are clear.
