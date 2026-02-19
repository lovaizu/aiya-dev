# Issue Format

The issue defines user value. It is reviewed at Gate 1 (Goal): do Benefit and SC capture the right user value?

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

## Success Criteria
- [ ] SC1: {Condition that verifies a Benefit is achieved} ← B1
- [ ] SC2: {Condition} ← B2

- Number each SC (SC1, SC2, ...) and link to its Benefit with ← Bn
- Each SC must verify a specific Benefit — an SC with no Benefit link is measuring the wrong thing
- Must be verifiable conditions, not tasks to complete
- Good: "SC1: A developer can create a worktree and start parallel work by following the documented steps ← B1"
- Bad: "SC1: CLAUDE.md has a Worktree section with setup instructions"
```
