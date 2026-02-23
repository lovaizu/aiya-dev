# Approach Design

Procedure for Phase 2 of the workflow: designing means to achieve Acceptance Scenarios.

## Purpose

Design an approach for every AS, structured as a PR that can be reviewed at Gate 2.

## Deliverable

A GitHub PR following `pr-format.md`:
- "Closes #N" linking to the issue
- Approach table with every AS mapped to a means
- Steps grouped by Approach

Work records in `.ciya/issues/nnnnn/`:
- `design.md` — Problem Summary, Approach, Key Decisions, Open Questions

## Generate

1. Read the issue's Acceptance Scenarios
2. For each AS, determine the means to achieve it
3. Draft the Approach table with every AS mapped to an approach
4. Group unique approaches under Step headings
5. Break each approach into concrete steps with checkboxes
6. Create a branch: `git fetch origin && git switch -c <branch-name> origin/main`
7. Create work records directory: `.ciya/issues/<5-digit-number>/`
8. Write `design.md` with Problem Summary, Approach, Key Decisions, Open Questions
9. Create the PR: `gh pr create`
10. Report the PR URL to the developer

## Verify

1. Every AS from the issue appears in the Approach table
2. Each Approach describes means (what), not rationale (why)
3. Steps are grouped by unique Approach
4. Each step is concrete and actionable
5. Steps collectively implement the Approach they belong to
6. Branch name describes the goal, not the implementation
7. `design.md` captures key decisions and rationale

## Iterate

- If any check fails, revise and re-verify all checks
- If the approach is non-obvious, explain why it was chosen over alternatives
- Present the verified PR to the developer for Gate 2 review
