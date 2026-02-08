#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: hi.sh <branch-name>" >&2
  exit 1
fi

branch="$1"
repo_root="$(cd "$(dirname "$0")/.." && pwd)"

cd "$repo_root"
git fetch origin
git pull origin main

git worktree add "$branch" -b "$branch" origin/main

cd "$repo_root/$branch"
exec claude
