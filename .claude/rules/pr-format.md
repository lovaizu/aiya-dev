# PR Format

The PR defines the means to achieve the Acceptance Scenarios. It is reviewed at Gate 2 (Approach): can Approach and Steps achieve all AS?

**Title:** A concise title describing the purpose of the work

**Body:**

```
Closes #{issue number}

## Approach

| AS | Approach |
|----|----------|
| AS1: Given ... When ... Then ... | {Means to achieve this AS} |
| AS2: Given ... When ... Then ... | {Means to achieve this AS} |

- Every AS from the issue must appear in the table — an uncovered AS will not be achieved
- Approach column contains the means (what), not the rationale (why)
- Explain why this approach was chosen over alternatives when the choice is non-obvious

## Steps

### {Approach}
- [ ] {Step}
- [ ] {Step}

### {Approach}
- [ ] {Step}
- [ ] {Step}

- One heading per unique Approach from the table
- If multiple ASs share the same Approach, use a single heading
- Each step must be a concrete, actionable work item
- Use checkboxes to track progress

## Expert Review

| Feedback | Improvement | Decision |
|----------|-------------|----------|
| {What the expert found} | {Proposed fix or change} | {Accepted/Rejected + reason} |

## Scenario Evaluation

Pseudo-execute each scenario as the target user. For each Given-When-Then, walk through the precondition, action, and expected outcome.

| Scenario | Status | Method | Judgment |
|----------|--------|--------|----------|
| {AS from the issue} | {OK/NG} | {Executed/Inspected} | {See format below} |

Judgment format by method:
- Executed: "As [who], did {When action} in {Given context}. Got {result}. {Then outcome} is satisfied/not satisfied"
- Inspected: "Cannot execute because {reason}. Inspected {what instead}. {Then outcome} is satisfied/not satisfied"
```

# PR Review Process

- Continue addressing reviews until the PR is approved
- Search for unresolved review comments and work through them one by one
- If something is unclear, reply to the review comment asking for clarification
- When making a fix: commit, push, then reply to the review comment
- Include a link to the commit in the reply when a fix is made
- Include `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>` in review replies
- Do NOT resolve review comments — the author of the comment will resolve them
- Do NOT create new comments on the PR — only reply to existing review comments
