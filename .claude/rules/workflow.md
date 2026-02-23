# Workflow

Follow this workflow for every task. Three phases, each with a purpose and a gate where the developer confirms the work meets expectations before proceeding.

## Phase 1: Goal (main/ worktree)

**Purpose:** Define user value — what Benefit to deliver and how to verify it. Getting the goal right prevents wasted implementation effort.

1. **Requirements Definition** (see `requirements-definition.md`)

2. **Gate 1 — Goal**
   - Developer reviews the issue on GitHub
   - `/fb` to address feedback comments on the issue
   - `/ty` to approve
   - **The developer asks:** Do Benefit and Acceptance Scenarios capture the right user value?
   - **Relevant:** Situation, Pain, Benefit, AS — are the facts accurate, the problem real, and the measure of success right?
   - **Irrelevant:** Implementation details, current architecture, technical feasibility

## Phase 2: Approach (work-N/ worktree)

**Purpose:** Design the means to achieve the Acceptance Scenarios. Reviewing the approach before implementation catches strategic mistakes early.

3. **Approach Design** (see `approach-design.md`)

4. **Gate 2 — Approach**
   - Developer reviews the PR on GitHub
   - `/fb` to address feedback comments on the PR
   - `/ty` to approve
   - **The developer asks:** Can Approach and Steps achieve all AS?
   - **Relevant:** Does Approach cover all AS? Do Steps implement the Approach? Is this the optimal strategy?
   - **Irrelevant:** Whether the goal itself is right (already approved at Gate 1)

## Phase 3: Delivery (work-N/ worktree)

**Purpose:** Implement and verify that the goal is achieved. Multiple verification steps catch different classes of issues before the developer reviews.

5. **Implementation**
   - Write code and make commits (split by purpose, one logical change per commit)
   - Push commits to the remote branch

6. **Consistency Check** (see `consistency-check.md`)

7. **Expert Review** (see `expert-review.md`)

8. **Scenario Evaluation** (see `scenario-evaluation.md`)

9. **Gate 3 — Verification**
    - Developer reviews the implementation on GitHub
    - `/fb` to address feedback comments on the PR
    - `/ty` to approve
    - **The developer asks:** Are AS met and Benefits realized?
    - **Relevant:** Are AS met? Are Benefits realized? Does the implementation match the approved Approach?
    - **Irrelevant:** Whether the approach was optimal (already approved at Gate 2)

10. **Merge**
    - Verify approval: `gh pr view <number> --json reviewDecision` must return `APPROVED`
    - If not `APPROVED`, ask the developer to approve the PR on GitHub first
    - Squash-merge: `gh pr merge <number> --squash`
    - Return to base branch and update: `git switch <work-N> && git fetch origin && git merge --ff-only origin/$CIYA_DEFAULT_BRANCH` — the worktree stays on a named branch at the latest main so the next task starts from a clean, current state
    - Delete task branch: `git push origin --delete <branch-name> && git branch -D <branch-name>`

11. **Done**
    - The work-N/ worktree is on its base branch at the latest main, ready for the next `/hi <number>`

## Gate Rejection

If the developer provides feedback instead of approving a gate, use `/fb` to address their comments and iterate until they approve with `/ty`.

## Interruption

At any point during the workflow, the developer can run `/bb` to:
- Save current state to `.ciya/issues/nnnnn/resume.md`
- Resume later with `/hi <number>` in any work-N/ worktree
