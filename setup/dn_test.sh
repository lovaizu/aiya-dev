#!/usr/bin/env bash
set -euo pipefail

# Test dn.sh — tmux session teardown
# Sources the actual dn.sh with SESSION_NAME pre-set and tmux stubbed.
#
# Manual tests (cannot be automated):
# - kill_session with a real tmux session: run ./dn.sh after ./up.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DN_SH="$SCRIPT_DIR/dn.sh"

passed=0
failed=0

assert_eq() {
  local test_name="$1" expected="$2" actual="$3"
  if [[ "$expected" == "$actual" ]]; then
    echo "  PASS: $test_name"
    ((++passed))
  else
    echo "  FAIL: $test_name"
    echo "    expected: $expected"
    echo "    actual:   $actual"
    ((++failed))
  fi
}

assert_contains() {
  local test_name="$1" needle="$2" haystack="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    echo "  PASS: $test_name"
    ((++passed))
  else
    echo "  FAIL: $test_name"
    echo "    expected to contain: $needle"
    echo "    actual:              $haystack"
    ((++failed))
  fi
}

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# ── kill_session (session exists) ─────────────────────────────
echo "kill_session (session exists):"

# Given: tmux reports the session exists and kill-session succeeds
stub_dir="$tmp/stub_exists"
mkdir -p "$stub_dir"
cat > "$stub_dir/tmux" <<'STUB'
#!/usr/bin/env bash
if [[ "$1" == "has-session" ]]; then
  exit 0
elif [[ "$1" == "kill-session" ]]; then
  exit 0
fi
STUB
chmod +x "$stub_dir/tmux"

# When: kill_session is called
output="$(
  export PATH="$stub_dir:$PATH"
  export SESSION_NAME="ciya-test"
  source "$DN_SH"
  kill_session
)"

# Then: it reports the session was stopped
assert_eq "reports stopped" "Stopped tmux session: ciya-test" "$output"

# ── kill_session (no session) ─────────────────────────────────
echo "kill_session (no session):"

# Given: tmux reports no session exists
stub_dir_no="$tmp/stub_no_session"
mkdir -p "$stub_dir_no"
cat > "$stub_dir_no/tmux" <<'STUB'
#!/usr/bin/env bash
if [[ "$1" == "has-session" ]]; then
  exit 1
fi
STUB
chmod +x "$stub_dir_no/tmux"

# When: kill_session is called
output="$(
  export PATH="$stub_dir_no:$PATH"
  export SESSION_NAME="ciya-test"
  source "$DN_SH"
  kill_session
)"

# Then: it reports no session is running
assert_eq "reports no session" "No tmux session named 'ciya-test' is running." "$output"

# ── usage ─────────────────────────────────────────────────────
echo "usage:"

# When: usage is called
output="$(
  source "$DN_SH"
  usage
)"

# Then: it shows help text
assert_contains "shows usage header" "Usage: dn.sh" "$output"
assert_contains "shows description" "Stop the CC development environment" "$output"

# ── main with -h ──────────────────────────────────────────────
echo "main:"

# When: main is called with -h
output="$(
  source "$DN_SH"
  main -h
)" || true
assert_contains "main -h shows usage" "Usage: dn.sh" "$output"

# When: main is called with --help
output="$(
  source "$DN_SH"
  main --help
)" || true
assert_contains "main --help shows usage" "Usage: dn.sh" "$output"

# When: main is called without arguments (stub tmux with no session)
output="$(
  export PATH="$stub_dir_no:$PATH"
  export SESSION_NAME="ciya-test"
  source "$DN_SH"
  main
)"
assert_eq "main no-args calls kill_session" "No tmux session named 'ciya-test' is running." "$output"

# ── Summary ───────────────────────────────────────────────────
echo ""
echo "Results: $passed passed, $failed failed"
[[ $failed -gt 0 ]] && exit 1
exit 0
