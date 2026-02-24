#!/usr/bin/env bash
set -euo pipefail

# dn.sh — Stop the CC development environment.
# Kills the tmux session started by up.sh.
#
# Usage:
#   ./dn.sh          Kill the aiya tmux session
#   ./dn.sh -h       Show help

SESSION_NAME="${SESSION_NAME:-aiya}"

usage() {
  cat <<'USAGE'
Usage: dn.sh [-h]

Stop the CC development environment by killing the tmux session.

  dn.sh          Kill the aiya tmux session
  dn.sh -h       Show this help
USAGE
}

kill_session() {
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux kill-session -t "$SESSION_NAME"
    echo "Stopped tmux session: $SESSION_NAME"
  else
    echo "No tmux session named '$SESSION_NAME' is running."
  fi
}

# --- Main (only when executed directly, not sourced) ---

main() {
  if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    usage
    exit 0
  fi

  kill_session
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then  # LCOV_EXCL_START
  main "$@"
fi  # LCOV_EXCL_STOP
