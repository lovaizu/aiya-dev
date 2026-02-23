# Requirements Definition

Procedure for Phase 1 of the workflow: defining user value.

## Purpose

Capture the developer's goal as a structured issue that can be reviewed at Gate 1.

## Deliverable

A GitHub issue following `issue-format.md`:
- Title in user story format
- Body with Situation, Pain, Benefit, and Acceptance Scenarios
- All traceability links complete

## Generate

### 1. Hearing

1. Ask the developer to describe their goal and why it matters
2. Ask clarifying questions until goal, scope, and target users are clear
3. Identify the concrete situation, affected users, and problems they face

### 2. Draft

1. Write the Situation section from gathered facts
2. Write the Pain table — derive each pain from the Situation
3. Write the Benefit table — link each benefit to a Pain
4. Write the Acceptance Scenarios tables — group by target user, link each scenario to a Benefit
5. Write the title in user story format: "As a [role], I want [goal] so that [benefit]"
6. Follow the format rules in `issue-format.md`

### 3. Create

1. Create the issue: `gh issue create`
2. Report the URL to the developer

## Verify

1. Every Pain arises from a fact in the Situation
2. Every Benefit traces to a Pain (Pain column filled)
3. Every Benefit uses "[who] can [what]" form
4. Every AS traces to a Benefit (Benefit column filled)
5. AS are grouped under headings matching [who] from their Benefits
6. Title [benefit] summarizes the primary Benefit
7. Title [goal] is the user's desired outcome, not an implementation detail
8. Each AS has concrete, observable Given-When-Then

## Iterate

- If any check fails, revise and re-verify all checks
- If requirements are unclear, ask the developer before revising
- Present the verified issue to the developer for Gate 1 review
