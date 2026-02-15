#!/usr/bin/env bash
# SessionStart hook — source .env to set environment variables

# Find repo root (ciya-dev/) by looking for .bare/ or going up from worktree
find_repo_root() {
  local dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.bare" ]; then
      echo "$dir"
      return
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

repo_root="$(find_repo_root)" || exit 0
env_file="$repo_root/.env"

if [ -f "$env_file" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$env_file"
  set +a
fi
