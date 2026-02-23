# Expert Review

Procedure for evaluating implementation quality from domain expert perspectives.

## Purpose

Identify correctness issues and best practice violations before delivery. Domain experts catch issues that generalists miss — a shell scripting expert spots portability problems, a prompt engineer spots instruction ambiguity.

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
2. Categorize files by domain — each domain has distinct best practices that require specialized evaluation:
   - Shell scripts → Shell scripting expert
   - Rules/prompts (`.claude/` markdown) → Prompt engineering expert
   - CI/CD (`.github/`) → CI/CD expert
   - Documentation → Technical writing expert
3. For each expert:
   a. Read each changed file in the domain
   b. Evaluate against the domain's best practices — search official documentation when uncertain
   c. Record findings with severity and proposed improvements — each finding must be specific enough to act on without ambiguity
   d. Write to `{domain}-expert-review.md` in the work records directory
4. Decide on each finding and fill in the Decision table:
   - **Accepted** — the finding is valid and the improvement should be implemented
   - **Rejected** — record the reason (e.g., false positive, acceptable trade-off, out of scope)
   - Accept findings that fix real issues; reject findings that are subjective preferences or low-value nitpicks
5. Implement all accepted improvements
6. Commit and push

## Verify

1. Every changed file is covered by at least one expert's scope
2. Each finding has a specific, actionable improvement — vague advice like "consider improving" is not actionable
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
