# Scenario Evaluation

Procedure for verifying Acceptance Scenarios by the agent acting as the target user.

## Purpose

Verify that each AS is met by the agent performing the scenario as the target user. Think about how you can evaluate before thinking about why you cannot — feasible evaluation methods exist more often than expected.

## Deliverable

A `scenario-evaluation.md` file in `.ciya/issues/nnnnn/`, with the following format:

```
# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | {OK/NG} | {Executed/Simulated/Inspected} | {judgment} |

Judgment format:
- Executed: "As [who], did {When} in {Given}. Got {result}. {Then} is satisfied/not satisfied."
- Simulated: "As [who], simulated {When} in {Given}. {Simulation steps and observed result}. {Then} is satisfied/not satisfied."
- Inspected: "Cannot execute or simulate because {reason}. Inspected {what}. {Then} is satisfied/not satisfied."
```

## Generate

1. Read the issue's Acceptance Scenarios tables
2. For each AS, identify [who], Given, When, Then
3. Evaluate each AS using the most concrete method available — think about how you can evaluate before listing reasons you cannot:
   a. **Execute**: Set up the Given context, perform the When action, observe the result — the gold standard because it produces concrete evidence
   b. **Simulate**: When direct execution is not possible, act as [who] and walk through the scenario step by step — read the relevant files, trace the control flow, and produce the same observable result the user would see. Simulation produces stronger evidence than inspection because the agent actively performs the scenario rather than passively reviewing code.
   c. **Inspect**: Last resort when neither execution nor simulation is feasible — explain why before falling back, then inspect the implementation
4. Record the judgment in the format above — adopt the target user's perspective ("As [who]") so the developer can see the scenario through the user's eyes
5. Write to `scenario-evaluation.md` in the work records directory

## Verify

1. Every AS from the issue has a row in the table
2. Each judgment uses the target user's perspective ("As [who]")
3. Executed scenarios have concrete observed results
4. Simulated scenarios describe the step-by-step walkthrough and observed outcome
5. Inspected scenarios explain why both execution and simulation were impossible
6. Every judgment states whether the Then outcome is satisfied
7. All AS have status OK

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
