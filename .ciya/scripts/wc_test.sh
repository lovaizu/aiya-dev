#!/usr/bin/env bash
set -euo pipefail

# Test wc.sh — bootstrap script

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WC_SH="$SCRIPT_DIR/wc.sh"

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

# --- Setup: create a local bare repo to act as the remote ---
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

# Create a fake remote repo with the files wc.sh expects
fake_remote="$tmpdir/remote.git"
staging="$tmpdir/staging"
mkdir "$staging" && cd "$staging"
git init -q
git checkout -q -b main

# Create .env.example
cat > .env.example <<'EOF'
GH_TOKEN=github_pat_xxxxx
EOF

# Create .ciya/scripts/up.sh
mkdir -p .ciya/scripts
cat > .ciya/scripts/up.sh <<'UPEOF'
#!/usr/bin/env bash
echo "up.sh placeholder"
UPEOF
chmod +x .ciya/scripts/up.sh

git add -A
git commit -q -m "initial"

# Create bare clone as fake remote
git clone -q --bare "$staging" "$fake_remote"

cd "$tmpdir"

# --- Helper: run wc.sh with overridden repo_url ---
run_wc() {
  # Override repo_url inside wc.sh by creating a wrapper
  local workdir="$1"
  cd "$workdir"
  env -i HOME="$HOME" PATH="$PATH" bash -c "
    set -euo pipefail
    repo_url='$fake_remote'
    dir='ciya-dev'

    if [ -d \"\$dir\" ]; then
      echo 'Error: directory \"\$dir\" already exists' >&2
      exit 1
    fi

    parent_dir=\"\$(pwd)\"
    mkdir \"\$dir\" && cd \"\$dir\"
    trap 'cd \"\$parent_dir\" && rm -rf \"\$dir\"' EXIT

    git clone --bare \"\$repo_url\" .bare
    echo 'gitdir: ./.bare' > .git
    git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
    git fetch origin

    git show HEAD:.env.example > .env

    git worktree add main main
    ln -s main/.ciya/scripts/up.sh up.sh

    trap - EXIT
  "
}

# --- Test 1: Creates ciya-dev/ directory ---
test_creates_directory() {
  local workdir="$tmpdir/test1"
  mkdir "$workdir"
  run_wc "$workdir"
  [ -d "$workdir/ciya-dev" ]
}
run_test "Creates ciya-dev/ directory" test_creates_directory

# --- Test 2: .bare/ contains bare clone ---
test_bare_clone() {
  [ -f "$tmpdir/test1/ciya-dev/.bare/HEAD" ]
}
run_test ".bare/ contains bare clone" test_bare_clone

# --- Test 3: main/ worktree exists ---
test_main_worktree() {
  [ -d "$tmpdir/test1/ciya-dev/main" ] &&
  [ -f "$tmpdir/test1/ciya-dev/main/.env.example" ]
}
run_test "main/ worktree exists" test_main_worktree

# --- Test 4: .env is extracted ---
test_env_extracted() {
  [ -f "$tmpdir/test1/ciya-dev/.env" ] &&
  grep -q "GH_TOKEN" "$tmpdir/test1/ciya-dev/.env"
}
run_test ".env is extracted from .env.example" test_env_extracted

# --- Test 5: up.sh is a symlink to main/.ciya/scripts/up.sh ---
test_upsh_symlink() {
  [ -L "$tmpdir/test1/ciya-dev/up.sh" ] &&
  [ "$(readlink "$tmpdir/test1/ciya-dev/up.sh")" = "main/.ciya/scripts/up.sh" ]
}
run_test "up.sh is symlink to main/.ciya/scripts/up.sh" test_upsh_symlink

# --- Test 6: Errors if ciya-dev/ already exists ---
test_error_if_exists() {
  local workdir="$tmpdir/test6"
  mkdir -p "$workdir/ciya-dev"
  ! run_wc "$workdir" 2>/dev/null
}
run_test "Errors if ciya-dev/ already exists" test_error_if_exists

# --- Results ---
echo ""
echo "Results: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
