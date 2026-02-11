#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: hi.sh <branch-name or path>" >&2
  exit 1
fi

branch="$(basename "$1")"
worktree_root="$(cd "$(dirname "$0")/../.." && pwd)"

worktree_dir="$worktree_root/$branch"

# Source .env if it exists in the worktree
if [ -f "$worktree_dir/.env" ]; then
  set -a
  # shellcheck disable=SC1091
  source "$worktree_dir/.env"
  set +a
fi

# Default ALLOWED_DOMAINS_FILE to the worktree's allowed-domains.txt
export ALLOWED_DOMAINS_FILE="${ALLOWED_DOMAINS_FILE:-$worktree_dir/.claude/hooks/allowed-domains.txt}"

if [ -d "$worktree_dir" ]; then
  # Resume existing worktree
  cd "$worktree_dir"
  exec claude --dangerously-skip-permissions
fi

# Create new worktree
cd "$worktree_root"
git -C "$worktree_root/main" pull --ff-only origin main || echo "Warning: could not update main (continuing)" >&2

git worktree add "$branch" -b "$branch" origin/main
cd "$worktree_root/$branch"
exec claude --dangerously-skip-permissions
