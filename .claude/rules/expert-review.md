# Expert Review

Procedure for evaluating implementation quality from domain expert perspectives.

## Purpose

Identify correctness issues and best practice violations before delivery.

## Deliverable

One `{domain}-expert-review.md` file per expert in `.ciya/issues/nnnnn/`, with the following format:

```
# {Domain} Expert Review

## Scope

| File | Description |
|------|-------------|
| {path} | {what changed} |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | {what was found} | {High/Medium/Low} | {proposed fix} |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 1 | {Accepted/Rejected} | {rationale} |
```

## Generate

1. List changed files: `git diff origin/main --name-only`
2. Categorize files by domain:
   - Shell scripts → Shell scripting expert
   - Rules/prompts (`.claude/` markdown) → Prompt engineering expert
   - CI/CD (`.github/`) → CI/CD expert
   - Documentation → Technical writing expert
3. For each expert:
   a. Read each changed file in the domain
   b. Evaluate against the domain's best practices
   c. Record findings with severity and proposed improvements
   d. Write to `{domain}-expert-review.md` in the work records directory
4. Commit and push the review files

### Developer Handoff

5. Tell the developer: "Expert review ready. Fill in the Decision table, then continue."
6. The developer reviews findings and records decisions:
   - **Accepted** — Agent implements the improvement
   - **Rejected** — Record the reason; no action needed
7. After the developer records decisions, read each file
8. Implement all accepted improvements
9. Commit and push

## Verify

1. Every changed file is covered by at least one expert's scope
2. Each finding has a specific, actionable improvement
3. All accepted improvements are implemented
4. Implemented changes do not introduce new issues

## Iterate

- If implementation reveals new issues, add them as findings and re-verify
- Continue until all accepted improvements are implemented and verified

## PR Body

Add links to work record files in the PR body:

```
## Expert Review

- [{Domain} Expert Review]({url})
```

Construct URL: `https://github.com/{owner}/{repo}/blob/{branch}/.ciya/issues/nnnnn/{domain}-expert-review.md`
- Get owner/repo: `gh repo view --json owner,name`
- Get branch: `git branch --show-current`
