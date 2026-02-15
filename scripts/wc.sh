#!/usr/bin/env bash
set -euo pipefail

# wc.sh — Welcome! One-time bootstrap for ciya-dev.
# Creates: ciya-dev/ with bare clone + .env + up.sh symlink
#
# Usage: curl -fsSL <raw-url>/wc.sh | bash

CIYA_REPO_URL="${CIYA_REPO_URL:-https://github.com/lovaizu/ciya-dev.git}"
CIYA_DEFAULT_BRANCH="${CIYA_DEFAULT_BRANCH:-main}"

# Derive directory name from repo URL (strip trailing .git and take basename)
dir="$(basename "${CIYA_REPO_URL%.git}")"

if [ -d "$dir" ]; then
  echo "Error: directory '$dir' already exists" >&2
  exit 1
fi

parent_dir="$(pwd)"
mkdir "$dir" && cd "$dir"
abs_dir="$parent_dir/$dir"
trap 'rm -rf "$abs_dir"' EXIT

# Bare clone
git clone -q --bare "$CIYA_REPO_URL" .bare
echo "gitdir: ./.bare" > .git
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch -q origin

# Extract .env from repo
git show "origin/$CIYA_DEFAULT_BRANCH:.env.example" > .env

# Symlink up.sh (will work once main/ worktree is created by up.sh)
# Create main worktree first so the symlink target exists
git worktree add main "$CIYA_DEFAULT_BRANCH"
ln -s main/scripts/up.sh up.sh

trap - EXIT

cat <<MSG

Welcome to $dir!

Next steps:
  1. cd $dir
  2. Edit .env with your tokens (GH_TOKEN is required)
  3. Run: ./up.sh <n>   (e.g., ./up.sh 4 for 4 work worktrees)

MSG
