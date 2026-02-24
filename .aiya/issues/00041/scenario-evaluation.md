# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | OK | Executed | As a developer, ran `git ls-files \| xargs grep -rli ciya` after the rename is complete. Got `Matches: 0`. Zero matches are returned is satisfied. |
| AS2 | OK | Executed | As a developer, confirmed repo renamed to `aiya-dev` via `gh repo view`. Ran `up_test.sh` (23/23 pass) and `wc_test.sh` (24/24 pass) with `AIYA_` env vars. `setup/up.sh` uses `AIYA_DEFAULT_BRANCH` and `AIYA_WORK_COUNT`. Worktrees are successfully set up is satisfied. |
| AS3 | OK | Simulated | As a developer, verified all command files (`/ok`, `/bb`, `/ty`) and rule files reference `.aiya/issues/` paths with zero `.ciya` references remaining. `.aiya/issues/00041/` directory exists with 5 work record files. Commands work correctly with `.aiya/issues/` paths is satisfied. |
