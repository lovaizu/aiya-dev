# Shell Scripting Expert Review

## Scope

| File | Description |
|------|-------------|
| setup/wc.sh | Renamed env vars CIYA_REPO_URL to AIYA_REPO_URL, CIYA_DEFAULT_BRANCH to AIYA_DEFAULT_BRANCH; updated comment references from ciya-dev to aiya-dev |
| setup/wc_test.sh | Updated fake remote name, env var references, and assertions from ciya to aiya |
| setup/up.sh | Renamed CIYA_DEFAULT_BRANCH to AIYA_DEFAULT_BRANCH, CIYA_WORK_COUNT to AIYA_WORK_COUNT; updated SESSION_NAME default from ciya to aiya; updated error message |
| setup/up_test.sh | Updated env var references and assertions from CIYA to AIYA, session name from ciya to aiya |
| setup/dn.sh | Updated SESSION_NAME default from ciya to aiya; updated comments and usage text |
| setup/dn_test.sh | Updated session name from ciya-test to aiya-test in all test cases |
| .claude/hooks/sandbox.sh | Renamed CIYA_ALLOWED_DOMAINS_FILE to AIYA_ALLOWED_DOMAINS_FILE throughout |
| .claude/hooks/sandbox_test.sh | Updated AIYA_ALLOWED_DOMAINS_FILE references |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | Grammar error in up.sh line 20: "does not look like a aiya-dev repo root" — "a aiya" should be "an aiya" because "aiya" starts with a vowel sound | Low | Change "a aiya-dev" to "an aiya-dev" on line 20 of setup/up.sh |
| 2 | The AIYA_REPO_URL in wc.sh defaults to `https://github.com/lovaizu/aiya-dev.git` but the actual GitHub repository is still named `ciya-dev` (confirmed via `gh repo view`). This means `curl ... | bash` would fail for new users until the GitHub repo is renamed. | High | This is an expected part of the rename — the repo URL should match the target name after the GitHub repo is renamed. If the GitHub rename has not happened yet, add a comment in wc.sh noting this depends on the repo rename. However, since the issue states the rename should be complete, this may be intentional as a pre-requisite. Confirm with the developer whether the GitHub repo rename is planned as a separate step. |
| 3 | All shell scripts consistently rename CIYA_ prefixed variables to AIYA_ — no missed references found via `git grep -in ciya` against tracked files | N/A | No action needed — rename is consistent |
| 4 | All test files pass (wc_test: 24/24, up_test: 23/23, dn_test: 7/7) — tests correctly validate the renamed variables and session names | N/A | No action needed — tests confirm correctness |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 1 | Accepted | Grammar error introduced by the rename — "a aiya" is incorrect English; should be "an aiya" |
| 2 | Rejected | The GitHub repo rename is a separate operational step outside this PR's scope. The code should reference the target name (aiya-dev) so it is correct after the rename. Adding a comment would be noise for a transient state. |
