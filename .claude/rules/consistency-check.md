# Consistency Check

Procedure for verifying traceability across issue and PR artifacts.

## Purpose

Ensure all artifacts (issue, PR, implementation) are consistent and traceable before evaluation.

## Deliverable

All inconsistencies identified and resolved. Issue and PR bodies updated as needed.

## Generate

1. Read the issue body (Situation, Pain, Benefit, AS)
2. Read the PR body (Approach table, Steps)
3. Cross-reference every linked pair:
   a. Title [benefit] ↔ primary Benefit
   b. Each Pain ↔ a Situation fact
   c. Each Benefit ↔ a Pain (via Pain column)
   d. Each AS ↔ a Benefit (via Benefit column)
   e. Each AS ↔ a row in the PR Approach table
   f. Each Approach ↔ a Step heading
   g. Each Step heading ↔ steps that implement the Approach
4. Record each inconsistency found

## Verify

1. No orphan Pains (every Pain traces to a Situation fact)
2. No orphan Benefits (every Benefit traces to a Pain)
3. No orphan AS (every AS traces to a Benefit)
4. No missing AS in the Approach table
5. No Approach without Steps
6. Title [benefit] accurately summarizes the primary Benefit
7. All links remain valid after any updates

## Iterate

- Fix each inconsistency and re-verify all checks
- If fixing one introduces another, re-check the full chain
- If a structural change is needed (e.g., a new AS discovered), discuss with the developer
