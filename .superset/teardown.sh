#!/usr/bin/env bash
# Stop anything this workspace started and release its port reservation.
set -uo pipefail
cd "$(dirname "$0")/.."
source .superset/ports.sh

if [ -f "$PORT_FILE" ]; then
  PORT=$(cat "$PORT_FILE")
  # Only kill dev servers running from this workspace.
  for pid in $(lsof -nP -t -iTCP:"$PORT" -sTCP:LISTEN 2>/dev/null); do
    cwd=$(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')
    if [ "$cwd" = "$WORKSPACE_PATH" ]; then
      echo "Stopping dev server (pid $pid) on port $PORT"
      kill "$pid" 2>/dev/null || true
    fi
  done
fi

release_port
echo "Teardown complete"
