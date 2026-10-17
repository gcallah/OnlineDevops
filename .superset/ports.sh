#!/usr/bin/env bash
# Shared helpers for per-workspace dev-server port allocation.
# Superset doesn't assign ports, so each workspace reserves one in a shared
# registry: one file per port under $PORT_REGISTRY, containing the owning
# workspace path. Files are created with noclobber, so claiming is atomic.

PORT_RANGE_START=8001
PORT_RANGE_END=8099
PORT_REGISTRY="${SUPERSET_HOME_DIR:-$HOME/.superset}/port-allocations/OnlineDevops"
WORKSPACE_PATH="${SUPERSET_WORKSPACE_PATH:-$(pwd)}"
PORT_FILE="$WORKSPACE_PATH/.superset/port"

port_in_use() {
  lsof -nP -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1
}

# Print this workspace's reserved port, reserving one if needed.
allocate_port() {
  mkdir -p "$PORT_REGISTRY"
  if [ -f "$PORT_FILE" ]; then
    local p
    p=$(cat "$PORT_FILE")
    if [ "$(cat "$PORT_REGISTRY/$p" 2>/dev/null)" = "$WORKSPACE_PATH" ]; then
      echo "$p"; return 0
    fi
  fi
  local p owner
  for p in $(seq "$PORT_RANGE_START" "$PORT_RANGE_END"); do
    owner=$(cat "$PORT_REGISTRY/$p" 2>/dev/null)
    # Reclaim reservations whose workspace no longer exists.
    if [ -n "$owner" ] && [ ! -d "$owner" ]; then
      rm -f "$PORT_REGISTRY/$p"
    fi
    port_in_use "$p" && continue
    if (set -o noclobber; echo "$WORKSPACE_PATH" > "$PORT_REGISTRY/$p") 2>/dev/null; then
      echo "$p" > "$PORT_FILE"
      echo "$p"; return 0
    fi
  done
  echo "No free port in $PORT_RANGE_START-$PORT_RANGE_END" >&2
  return 1
}

release_port() {
  [ -f "$PORT_FILE" ] || return 0
  local p
  p=$(cat "$PORT_FILE")
  if [ "$(cat "$PORT_REGISTRY/$p" 2>/dev/null)" = "$WORKSPACE_PATH" ]; then
    rm -f "$PORT_REGISTRY/$p"
  fi
  rm -f "$PORT_FILE"
}
