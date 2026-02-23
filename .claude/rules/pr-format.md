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

- [{Domain} Expert Review]({url to work record})

One link per domain expert — see `expert-review.md` for procedure and format

## Scenario Evaluation

- [Scenario Evaluation]({url to work record})

See `scenario-evaluation.md` for procedure and format
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
