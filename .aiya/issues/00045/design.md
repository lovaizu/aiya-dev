## Problem Summary

Success Criteria use abstract condition format ("condition that verifies a Benefit is achieved") which doesn't decompose into who-does-what-in-what-context. This makes gate reviews and agent SC Checks ambiguous. The issue asks to replace SC with Acceptance Scenarios in Given-When-Then format, grouped by target user.

## Approach

Replace "Success Criteria" with "Acceptance Scenarios" across all format rules, workflow rules, and documentation. The new format uses Given-When-Then grouped by target user (the [who] from Benefits).

Files to change:
1. `issue-format.md` — Replace SC section with Acceptance Scenarios (GWT format, grouped by target user)
2. `pr-format.md` — Replace SC references with AS, rename "Success Criteria Check" to "Scenario Evaluation"
3. `workflow.md` — Update all SC references to AS throughout the workflow
4. `README.md` — Update SC references to AS in documentation
5. `.claude/commands/hi.md` — Update SC references to AS

## Key Decisions

- Use "AS" prefix for numbering (AS1, AS2, ...) instead of "SC" — consistent with issue #45's own format
- Keep traceability links (← Bn) on scenarios
- Group scenarios under ### headings by target user role
- Each scenario uses Given-When-Then with indented lines
- PR Approach table references AS instead of SC
- "Success Criteria Check" becomes "Scenario Evaluation" with adapted columns

## Open Questions

None — the issue itself demonstrates the target format clearly.
