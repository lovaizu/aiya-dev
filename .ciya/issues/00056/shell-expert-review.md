# Shell Scripting Expert Review

## Scope

| File | Description |
|------|-------------|
| setup/wc.sh | Changed source guard from `${BASH_SOURCE[0]}` to `${BASH_SOURCE[0]:-$0}` to handle piped execution |
| setup/wc_test.sh | Added source guard tests for pipe, direct, and sourced execution modes |

## Evaluation

| # | Finding | Severity | Improvement |
|---|---------|----------|-------------|
| 1 | The `${BASH_SOURCE[0]:-$0}` pattern is correct and idiomatic. When `BASH_SOURCE` is an empty array (piped input), the `:-` default expansion provides `$0`, making the guard evaluate to `[[ "$0" == "$0" ]]` which is true. When sourced, `BASH_SOURCE[0]` is the sourced file while `$0` is the caller, so they differ. When executed directly, both equal the script path. All three modes behave correctly. | Low | No change needed — noting correctness for the record. |
| 2 | The pipe test uses `cat "$tmp/guard_test.sh" \| env -u BASH_ENV bash` rather than `env -u BASH_ENV bash < "$tmp/guard_test.sh"`. The `cat \| bash` form is a closer simulation of `curl \| bash` (both pipe stdin to bash), while `<` redirect is a different mechanism. However, on bash 5.x both produce identical `BASH_SOURCE` behavior (`BASH_SOURCE[0]` is unset in both cases). The `cat` form is justified here because the intent is explicitly to simulate `curl \| bash`. | Low | No change needed — the `cat` pipe intentionally mirrors the `curl \| bash` invocation being fixed. |
| 3 | The `env -u BASH_ENV` workaround in the test is undocumented beyond a single inline comment. When kcov instruments bash scripts, it sets `BASH_ENV` to a PS4 helper that auto-sources into child bash processes. Without `env -u BASH_ENV`, the child bash inherits kcov's instrumentation, which can inject unexpected output (the kcov PS4 trace) that breaks assertions. The inline comment is adequate. | Low | No change needed — the comment on line 375 explains the purpose sufficiently. |
| 4 | The source guard test creates a separate `guard_test.sh` file with a duplicated guard pattern rather than testing the actual `wc.sh` guard directly. This means the test could pass even if `wc.sh` were changed to use a different pattern. However, the last assertion (`assert_contains "wc.sh uses safe guard" 'BASH_SOURCE[0]:-$0' "$(cat "$WC_SH")"`) mitigates this by verifying the pattern string exists in `wc.sh`. The duplication is justified because testing `wc.sh` directly in pipe mode would require stubbing all `ensure_*` functions and `main`, which is not feasible for a stdin-piped execution. | Low | No change needed — the `assert_contains` check closes the gap between the proxy test and the actual file. |
| 5 | The test file's `output="$(source "$tmp/guard_test.sh" 2>&1)"` runs `source` inside a command substitution subshell. In bash, `source` inside `$(...)` correctly sets `BASH_SOURCE[0]` to the sourced file while `$0` remains the outer script, so the guard correctly evaluates to false. This is valid behavior. | Low | No change needed — bash `source` semantics are correct inside command substitution. |
| 6 | The guard pattern `[[ "${BASH_SOURCE[0]:-$0}" == "$0" ]]` is bash-specific (uses `[[ ]]` and bash array). The script already has a `#!/usr/bin/env bash` shebang and uses bashisms throughout (`set -euo pipefail`, `local`, arrays), so POSIX compatibility is not a concern. The pattern is appropriate for the target shell. | Low | No change needed — the script is explicitly bash and the pattern matches. |
| 7 | The `$0` in the default value `${BASH_SOURCE[0]:-$0}` is not quoted inside the parameter expansion. This is safe because the entire expression is already within double quotes (`"${BASH_SOURCE[0]:-$0}"`), which means `$0` undergoes variable expansion but not word splitting or globbing. The quoting is correct. | Low | No change needed — the double-quoted parameter expansion protects `$0` from splitting. |

## Decision

| # | Decision | Reason |
|---|----------|--------|
| 1 | Rejected | Informational finding confirming correctness — no action needed |
| 2 | Rejected | The `cat \| bash` form is intentional and appropriate for simulating `curl \| bash` |
| 3 | Rejected | The inline comment is adequate for explaining the `env -u BASH_ENV` workaround |
| 4 | Rejected | The `assert_contains` check provides sufficient coupling between the proxy test and the actual source guard |
| 5 | Rejected | Informational finding confirming correctness — no action needed |
| 6 | Rejected | Informational finding confirming the pattern matches the target shell — no action needed |
| 7 | Rejected | Informational finding confirming quoting correctness — no action needed |
