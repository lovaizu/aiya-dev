# Step Design

Rules for writing procedural work steps in workflow and rule files. Every procedure follows the Generate-Verify-Iterate pattern.

## Step Structure

Each procedure must define:

1. **Purpose** — What this procedure achieves (one sentence)
2. **Deliverable** — Observable output with acceptance criteria, derived from the purpose and related rules
3. **Generate** — Imperative instructions to produce the deliverable
4. **Verify** — Checks that confirm the deliverable achieves the purpose
5. **Iterate** — Revise and re-verify until all checks pass

## Writing Instructions

- Write each instruction as an imperative command with one action
- State preconditions when a step depends on prior results
- Specify the exact output format (table, file, checklist) for deliverables
- Use positive instructions ("Do X") rather than negative ones ("Don't do Y")

## Generate

- Take the purpose as the primary input
- Scan the repository for all relevant context to avoid gaps
- Cross-reference with requirements and related rules for completeness

## Verify

- Take the purpose and deliverable criteria as inputs
- Each check must be specific and independently judgeable (pass/fail)
- Checks must confirm purpose achievement, not just format compliance
- Include traceability checks when the deliverable references other artifacts

## Iterate

- If any check fails, revise the deliverable and re-verify all checks
- Continue until all checks pass
- If a check cannot pass, explain why and escalate to the developer
