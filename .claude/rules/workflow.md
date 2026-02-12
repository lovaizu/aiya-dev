# Workflow

Follow this workflow for every task:

1. **Hearing**
   - Gather requirements from the developer
   - Ask clarifying questions until the goal and scope are clear

2. **Issue creation**
   - Draft the issue title in user story format (see `issue-format.md`)
   - Draft the issue body with Situation, Pain, Benefit, and Success Criteria
   - Create the issue on GitHub with `gh issue create`
   - Present the GitHub issue link to the developer

3. **Goal approval**
   - The developer reviews the issue on GitHub's web page
   - If the developer leaves comments on the issue, address them using `/fb`
   - Wait for the developer to approve the goal

4. **PR description**
   - Draft the PR title (concise, describes purpose)
   - Draft the PR body with Approach and Tasks (see `pr-format.md`)
   - Ensure Approach addresses each Pain from the issue
   - Ensure Tasks are traceable to the Approach
   - Create an empty commit: `git commit --allow-empty`
   - Push the branch and create the PR: `gh pr create`
   - Name the branch per the rules in `git-conventions.md`
   - Present the GitHub PR link to the developer

5. **Approach approval**
   - The developer reviews the PR description on GitHub's web page
   - If the developer leaves comments on the PR, address them using `/fb`
   - Wait for the developer to approve the approach

6. **Implementation**
   - Write code and make commits (split by purpose, one logical change per commit)
   - Push commits to the remote branch

7. **Consistency check**
   - Verify issue title [goal] matches one of the Benefits
   - Verify each Success Criteria maps to a Benefit
   - Verify PR Approach addresses each Pain
   - Verify PR Tasks are traceable to the Approach
   - If any section was updated during earlier steps, re-check all sections
   - Fix any inconsistencies found

8. **Expert review**
   - Identify the technical domain of the deliverable
   - Simulate a review from a domain expert perspective
   - Evaluate correctness, best practices, and potential issues
   - Fix any problems found
   - Append the Expert Review table to the PR body (see `pr-format.md`)

9. **Success Criteria check**
   - Read the issue's Success Criteria
   - For each criterion: execute it as written (prefer execution over inspection)
   - If execution is truly not possible, explain why before falling back to inspection
   - Update the issue body to check off completed Success Criteria checkboxes (fetch with `gh issue view`, modify, update with `gh issue edit --body`)
   - Append the Success Criteria Check table to the PR body (see `pr-format.md`)
   - If any criterion is NG, address it and re-check

10. **Goal verification**
    - Request review from the developer
    - Address feedback (see PR Review Process in `pr-format.md`)
    - Wait for developer approval

11. **Merge**
    - Verify approval: `gh pr view <number> --json reviewDecision` must return `APPROVED`
    - If not `APPROVED`, confirm with the developer before proceeding
    - Squash-merge: `gh pr merge <number> --squash`
    - The developer will clean up the worktree and branch using `bb.sh`

12. **Done**
