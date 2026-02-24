# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | OK | Executed | As a developer, ran `git ls-files \| xargs grep -rli ciya` after the rename is complete. Got `Matches: 0`. Zero matches are returned is satisfied. |
| AS2 | Pending | - | Requires repository rename to `aiya-dev` before verification. `setup/up.sh` uses `AIYA_` env vars; all 23 unit tests pass. Full verification after repo rename. |
| AS3 | Pending | - | Requires repository rename to `aiya-dev` before verification. All `.aiya/issues/` path references updated in `/ok`, `/bb`, `/ty` commands. Full verification after repo rename. |
