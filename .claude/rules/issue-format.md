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
- P1: {Who is affected and what problem they face}
- P2: {Problem}

- Number each Pain (P1, P2, ...)
- Each Pain must arise from the Situation — a Pain with no Situation basis is an ungrounded assumption

## Benefit
- B1: {Who benefits and how, once resolved} ← P1
- B2: {Benefit} ← P2

- Number each Benefit (B1, B2, ...) and link to its Pain with ← Pn
- Use "[who] can [what]" form
- Each Benefit must trace from a Pain — a Benefit with no Pain link is solving a problem that doesn't exist
- Good: "B1: Developers can run multiple tasks in parallel ← P1"
- Bad: "B1: Development throughput is improved"

## Acceptance Scenarios

### {[who] from Benefit}
- [ ] AS1: Given {context or precondition}
  When {action the [who] takes}
  Then {observable outcome that verifies the Benefit} ← B1

- [ ] AS2: Given {context}
  When {action}
  Then {outcome} ← B1

### {Another [who] from Benefit}
- [ ] AS3: Given {context}
  When {action}
  Then {outcome} ← B2

- Number each scenario (AS1, AS2, ...) and link to its Benefit with ← Bn
- Group scenarios under ### headings by the [who] from the Benefit they verify
- Each scenario must verify a specific Benefit — a scenario with no Benefit link is measuring the wrong thing
- Use Given-When-Then format:
  - Given: the situation or precondition the [who] is in
  - When: the action the [who] takes
  - Then: the observable outcome that proves the Benefit is achieved
- Multiple scenarios may verify the same Benefit from different angles
```
