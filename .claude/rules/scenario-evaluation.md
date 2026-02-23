# Scenario Evaluation

Procedure for verifying Acceptance Scenarios through execution as the target user.

## Purpose

Verify that each AS is met from the target user's perspective. Only the target user's perspective can confirm the benefit is realized — format compliance alone does not prove the user's problem is solved.

## Deliverable

A `scenario-evaluation.md` file in `.ciya/issues/nnnnn/`, with the following format:

```
# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | {OK/NG} | {Executed/Inspected} | {judgment} |

Judgment format:
- Executed: "As [who], did {When} in {Given}. Got {result}. {Then} is satisfied/not satisfied."
- Inspected: "Cannot execute because {reason}. Inspected {what}. {Then} is satisfied/not satisfied."
```

## Generate

1. Read the issue's Acceptance Scenarios tables
2. For each AS, identify [who], Given, When, Then
3. Prefer execution over inspection — execution produces concrete evidence, while inspection only confirms the implementation looks correct:
   a. **Execute**: Set up the Given context, perform the When action as [who], observe the result
   b. **Inspect**: Only when execution is impossible — explain why before falling back, then inspect the implementation
4. Record the judgment in the format above — adopt the target user's perspective ("As [who]") so the developer can see the scenario through the user's eyes
5. Write to `scenario-evaluation.md` in the work records directory

## Verify

1. Every AS from the issue has a row in the table
2. Each judgment uses the target user's perspective ("As [who]")
3. Executed scenarios have concrete observed results
4. Inspected scenarios explain why execution was impossible
5. Every judgment states whether the Then outcome is satisfied
6. All AS have status OK

## Iterate

- If any AS is NG, fix the underlying issue and re-evaluate the failed scenario
- Continue until all scenarios are OK
- If an AS cannot be satisfied, escalate to the developer

## PR Body

Add a link to the work record file in the PR body:

```
## Scenario Evaluation

- [Scenario Evaluation]({url})
```

Construct URL: `https://github.com/{owner}/{repo}/blob/{branch}/.ciya/issues/nnnnn/scenario-evaluation.md`
- Get owner/repo: `gh repo view --json owner,name`
- Get branch: `git branch --show-current`
