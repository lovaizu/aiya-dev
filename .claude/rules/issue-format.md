# Issue Format

The issue defines user value. It is reviewed at Gate 1 (Goal): do Benefit and Acceptance Scenarios capture the right user value?

**Title:** Use user story format: "As a [role], I want [goal] so that [benefit]"

- [goal] must be the user's desired outcome, not a technical means or implementation detail
- [benefit] in the title must summarize the primary Benefit from the body's Benefit section
- Good: "I want to run multiple tasks in parallel"
- Bad: "I want a bare repo + worktree structure"

**Body:**

```
## Situation
{Concrete facts and observed circumstances}

## Pain

| # | Pain |
|---|------|
| P1 | {Who is affected and what problem they face} |
| P2 | {Problem} |

- Each Pain must arise from the Situation — a Pain with no Situation basis is an ungrounded assumption

## Benefit

| Pain | # | Benefit |
|------|---|---------|
| P1 | B1 | {Who benefits and how, once resolved} |
| P2 | B2 | {Benefit} |

- Use "[who] can [what]" form
- Each Benefit must trace from a Pain — a Benefit with no Pain link is solving a problem that doesn't exist
- Good: "Developers can run multiple tasks in parallel"
- Bad: "Development throughput is improved"

## Acceptance Scenarios

### {[who] from Benefit}

| Benefit | AS | Given | When | Then |
|---------|----|-------|------|------|
| B1 | AS1 | {context or precondition} | {action the [who] takes} | {observable outcome that verifies the Benefit} |
| B1 | AS2 | {context} | {action} | {outcome} |

### {Another [who] from Benefit}

| Benefit | AS | Given | When | Then |
|---------|----|-------|------|------|
| B2 | AS3 | {context} | {action} | {outcome} |

- Group scenarios under ### headings by the [who] from the Benefit they verify
- Each scenario must verify a specific Benefit — a scenario with no Benefit link is measuring the wrong thing
- Given: the situation or precondition the [who] is in
- When: the action the [who] takes
- Then: the observable outcome that proves the Benefit is achieved
- Multiple scenarios may verify the same Benefit from different angles
```
