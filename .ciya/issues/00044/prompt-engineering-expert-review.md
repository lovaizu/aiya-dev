# Prompt Engineering Expert Review

## Scope

| File | Description |
|------|-------------|
| .claude/rules/workflow.md | Updated step 10 merge cleanup to return to base branch |
| .claude/commands/hi.md | Added base branch fast-forward before task branch creation |
| .claude/commands/ty.md | Updated Gate 3 merge cleanup to match workflow.md |
| .ciya/issues/00044/design.md | Work records for issue #44 |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | workflow.md uses `origin/$CIYA_DEFAULT_BRANCH` but hi.md and ty.md use `origin/main`. The agent executes these as shell commands — `$CIYA_DEFAULT_BRANCH` may not be in the agent's environment. The original hi.md used `origin/main` directly. | High | Use `origin/main` consistently in all three files, matching the existing convention in hi.md and approach-design.md |
| 2 | ty.md step 4 combines two distinct operations (return to base branch + delete task branch) in a single step. The step-design rule says "one action per instruction" for clarity. | Medium | Split step 4 into two steps: (4) return to base branch and update, (5) delete task branch. Renumber subsequent steps. |

## Decision

| # | Decision | Reason |
|---|----------|--------|
