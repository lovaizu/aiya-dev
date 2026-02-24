# Design

## Problem Summary

`wc.sh` uses `${BASH_SOURCE[0]}` in its source guard (line 121) to distinguish direct execution from `source` for testing. With `set -euo pipefail`, the `-u` flag treats unset variables as errors. When piped via `curl | bash`, `BASH_SOURCE` is an empty array, causing an "unbound variable" error that aborts setup.

## Approach

Replace `${BASH_SOURCE[0]}` with `${BASH_SOURCE[0]:-$0}` in the source guard. When `BASH_SOURCE[0]` is unset (piped input), it defaults to `$0`, making the condition true so `main` executes. When sourced, `BASH_SOURCE[0]` is set and differs from `$0`, so `main` is skipped. This single-character change preserves all three execution modes:

1. `curl | bash` → `BASH_SOURCE[0]` unset → defaults to `$0` → condition true → `main` runs
2. `bash wc.sh` → `BASH_SOURCE[0]` equals `$0` → condition true → `main` runs
3. `source wc.sh` → `BASH_SOURCE[0]` differs from `$0` → condition false → `main` skipped

## Key Decisions

- **`${BASH_SOURCE[0]:-$0}` over `${BASH_SOURCE[0]:-}`**: Defaulting to `$0` makes the guard naturally correct for piped execution without needing a separate condition. Defaulting to empty string would require `[[ -z "${BASH_SOURCE[0]:-}" ]] || [[ "${BASH_SOURCE[0]}" == "$0" ]]`, which is less readable.
- **No `set +u` workaround**: Temporarily disabling `set -u` around the guard would work but weakens the safety net and sets a bad precedent.

## Open Questions

None.
