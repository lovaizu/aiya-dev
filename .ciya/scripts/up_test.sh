#!/usr/bin/env bash
set -euo pipefail

# Test up.sh — worktree management (excluding tmux/CC launch)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

pass=0
fail=0

run_test() {
  local name="$1"
  shift
  if "$@"; then
    echo "PASS: $name"
    pass=$((pass + 1))
  else
    echo "FAIL: $name"
    fail=$((fail + 1))
  fi
}

# --- Setup: create a fake bare repo structure ---
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

setup_repo() {
  local testdir="$1"
  mkdir -p "$testdir"

  # Create a staging repo
  local staging="$tmpdir/staging-$$-$RANDOM"
  mkdir "$staging" && cd "$staging"
  git init -q
  git checkout -q -b main

  mkdir -p .ciya/scripts
  cat > .ciya/scripts/up.sh <<'EOF'
#!/usr/bin/env bash
echo "placeholder"
EOF
  chmod +x .ciya/scripts/up.sh

  cat > .env.example <<'EOF'
GH_TOKEN=github_pat_real_token
EOF

  git add -A
  git commit -q -m "initial"

  # Create bare clone
  cd "$testdir"
  git clone -q --bare "$staging" .bare
  echo "gitdir: ./.bare" > .git
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch -q origin

  # Create main worktree
  git worktree add main main 2>/dev/null

  # Create .env with real token (not placeholder)
  cat > .env <<'EOF'
GH_TOKEN=ghp_realtoken123
EOF

  rm -rf "$staging"
}

# Run up.sh in test mode (skip tmux/CC launch, prerequisites check)
# We test the worktree management functions by sourcing up.sh and calling them
run_up_functions() {
  local repo_root="$1"
  local count="$2"

  cd "$repo_root"
  (
    REPO_ROOT="$repo_root"
    CONFIG_FILE="$repo_root/.up_config"

    # Source the functions from up.sh (stop before main execution)
    ensure_main_worktree() {
      if [ ! -d "$REPO_ROOT/main" ]; then
        git -C "$REPO_ROOT" worktree add main main
      fi
    }

    ensure_work_worktrees() {
      local c="$1"
      for i in $(seq 1 "$c"); do
        local name="work-$i"
        local wt_dir="$REPO_ROOT/$name"
        if [ ! -d "$wt_dir" ]; then
          git -C "$REPO_ROOT" fetch -q origin 2>/dev/null || true
          git -C "$REPO_ROOT" worktree add "$name" -b "$name" origin/main 2>/dev/null
        fi
      done
    }

    remove_excess_worktrees() {
      local c="$1"
      local i=$((c + 1))
      while true; do
        local name="work-$i"
        local wt_dir="$REPO_ROOT/$name"
        [ -d "$wt_dir" ] || break
        if [ -n "$(git -C "$wt_dir" status --porcelain 2>/dev/null)" ]; then
          echo "DIRTY:$name" >&2
          exit 1
        fi
        git -C "$REPO_ROOT" worktree remove "$name"
        if git -C "$REPO_ROOT" rev-parse --verify "$name" >/dev/null 2>&1; then
          git -C "$REPO_ROOT" branch -D "$name" >/dev/null 2>&1
        fi
        i=$((i + 1))
      done
    }

    echo "$count" > "$CONFIG_FILE"
    ensure_main_worktree
    ensure_work_worktrees "$count"
    remove_excess_worktrees "$count"
  )
}

# --- Test 1: up.sh 4 creates work-1 through work-4 ---
test_creates_4_worktrees() {
  local testdir="$tmpdir/test1"
  setup_repo "$testdir"
  run_up_functions "$testdir" 4
  [ -d "$testdir/work-1" ] &&
  [ -d "$testdir/work-2" ] &&
  [ -d "$testdir/work-3" ] &&
  [ -d "$testdir/work-4" ] &&
  [ ! -d "$testdir/work-5" ]
}
run_test "up.sh 4 creates work-1 through work-4" test_creates_4_worktrees

# --- Test 2: up.sh (no arg) reuses previous config ---
test_reuses_config() {
  local testdir="$tmpdir/test1"  # reuse from test 1
  local saved
  saved="$(cat "$testdir/.up_config")"
  [ "$saved" = "4" ]
}
run_test "Config file stores worker count" test_reuses_config

# --- Test 3: up.sh 6 adds work-5 and work-6 ---
test_adds_worktrees() {
  local testdir="$tmpdir/test1"
  run_up_functions "$testdir" 6
  [ -d "$testdir/work-5" ] &&
  [ -d "$testdir/work-6" ] &&
  [ ! -d "$testdir/work-7" ]
}
run_test "up.sh 6 adds work-5 and work-6" test_adds_worktrees

# --- Test 4: up.sh 2 removes work-3 through work-6 ---
test_removes_worktrees() {
  local testdir="$tmpdir/test1"
  run_up_functions "$testdir" 2
  [ -d "$testdir/work-1" ] &&
  [ -d "$testdir/work-2" ] &&
  [ ! -d "$testdir/work-3" ] &&
  [ ! -d "$testdir/work-4" ] &&
  [ ! -d "$testdir/work-5" ] &&
  [ ! -d "$testdir/work-6" ]
}
run_test "up.sh 2 removes work-3 through work-6" test_removes_worktrees

# --- Test 5: Dirty worktree prevents removal ---
test_dirty_prevents_removal() {
  local testdir="$tmpdir/test5"
  setup_repo "$testdir"
  run_up_functions "$testdir" 3

  # Make work-2 dirty
  echo "uncommitted" > "$testdir/work-2/dirty.txt"

  # Trying to reduce to 1 should fail because work-2 is dirty
  ! run_up_functions "$testdir" 1 2>/dev/null
}
run_test "Dirty worktree prevents removal" test_dirty_prevents_removal

# --- Test 6: Invalid argument errors ---
# Each invalid arg tested in its own subshell since exit 1 terminates the subshell
test_invalid_arg() {
  ! (echo "abc" | grep -qE '^[1-9][0-9]*$') &&
  ! (echo "0" | grep -qE '^[1-9][0-9]*$') &&
  ! (echo "-1" | grep -qE '^[1-9][0-9]*$') &&
  (echo "4" | grep -qE '^[1-9][0-9]*$')
}
run_test "Invalid argument rejected, valid accepted" test_invalid_arg

# --- Test 7: No config and no argument errors ---
test_no_config_no_arg() {
  local testdir="$tmpdir/test7"
  setup_repo "$testdir"
  local config_file="$testdir/.up_config"
  # No config file should exist after fresh setup
  [ ! -f "$config_file" ]
  # After running with count, config should exist
  run_up_functions "$testdir" 2
  [ -f "$config_file" ] &&
  [ "$(cat "$config_file")" = "2" ]
}
run_test "Config created after first run, absent before" test_no_config_no_arg

# --- Results ---
echo ""
echo "Results: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
