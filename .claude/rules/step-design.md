# Step Design

Rules for writing procedural work steps in workflow and rule files.

When steps are vague or lack observable criteria, the agent cannot self-assess whether it succeeded and may drift from the intended purpose. The Generate-Verify-Iterate pattern ensures each procedure produces a verifiable deliverable and self-corrects until the purpose is achieved.

## Step Structure

Each procedure defines these sections:

1. **Purpose** — What this procedure achieves and why it matters. The purpose gives the agent context to handle edge cases the instructions don't explicitly cover.
2. **Deliverable** — The observable output with acceptance criteria. Specify the exact format (table columns, file path, section structure) so the agent can self-assess completeness.
3. **Generate** — Imperative instructions to produce the deliverable. One action per instruction, with context explaining why each step matters.
4. **Verify** — Pass/fail checks that confirm the deliverable achieves the purpose, not just that it follows format rules.
5. **Iterate** — Revise the deliverable and re-verify until all checks pass. Escalate to the developer when a check cannot pass.

## Writing Instructions

Write each instruction as an imperative command with one action.

Add context behind instructions — explain WHY, not just WHAT. When the agent understands the reason behind an instruction, it generalizes correctly to situations the instruction didn't explicitly cover.

<example>
Less effective:
"Write the Pain table"

More effective:
"Write the Pain table — derive each pain from the Situation so the developer can trace every problem back to observed facts"
</example>

State preconditions when a step depends on prior results: "Requires: issue approved at Gate 1."

Use positive instructions that describe the desired behavior rather than prohibitions. The agent follows positive instructions more reliably.

<example>
Less effective:
"Do not write implementation details in the title"

More effective:
"Write the title as the user's desired outcome: 'I want to run multiple tasks in parallel'"
</example>

Provide aligned examples where the distinction between good and bad output is non-obvious. The agent pays close attention to example patterns, so ensure examples demonstrate the behavior you want.

## Generate

- Take the purpose as the primary input
- Scan the repository for all relevant files, rules, and conventions to avoid gaps
- Cross-reference with requirements and related rules for completeness
- Specify the exact output format (table, file, checklist) for each deliverable

## Verify

Each check must be:

- **Specific** — One condition, answerable as pass or fail
- **Purpose-oriented** — Confirms the purpose is achieved, not just that format rules are followed
- **Traceable** — When the deliverable references other artifacts, verifies the link is valid

<example>
Less effective:
"Verify the issue is correct"

More effective:
"Every Benefit traces to a Pain (Pain column filled)"
</example>

## Iterate

- If any check fails, identify the gap, revise the deliverable, and re-verify all checks
- Continue until all checks pass
- If a check cannot pass due to external constraints, explain the constraint and escalate to the developer
