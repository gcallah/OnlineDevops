#!/usr/bin/env bash
# Stop anything this workspace started and release its port reservation.
set -uo pipefail
cd "$(dirname "$0")/.."
source .superset/ports.sh

# The dev server started by run.sh (Django's autoreloader parent).
if [ -f "$PID_FILE" ]; then
  pid=$(cat "$PID_FILE")
  if kill -0 "$pid" 2>/dev/null; then
    echo "Stopping dev server (pid $pid)"
    kill "$pid" 2>/dev/null || true
  fi
  rm -f "$PID_FILE"
fi

# Any remaining listener on our port whose cwd is this workspace.
if [ -f "$PORT_FILE" ]; then
  PORT=$(cat "$PORT_FILE")
  here=$(pwd -P)
  for pid in $(lsof -nP -t -iTCP:"$PORT" -sTCP:LISTEN 2>/dev/null); do
    cwd=$(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')
    if [ "$cwd" = "$here" ]; then
      echo "Stopping process $pid listening on port $PORT"
      kill "$pid" 2>/dev/null || true
    fi
  done
fi

release_port
echo "Teardown complete"
