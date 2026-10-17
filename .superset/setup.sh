#!/usr/bin/env bash
# Prepare a fresh Superset workspace. Idempotent: safe to re-run.
set -euo pipefail
cd "$(dirname "$0")/.."
source .superset/ports.sh

ROOT="${SUPERSET_ROOT_PATH:-}"

echo "==> Initializing git submodules"
git submodule update --init --recursive

echo "==> Copying untracked local files from main checkout"
if [ -n "$ROOT" ] && [ -d "$ROOT" ] && [ "$ROOT" != "$(pwd)" ]; then
  for f in .env .env.local; do
    if [ -f "$ROOT/$f" ] && [ ! -e "$f" ]; then
      cp "$ROOT/$f" "$f" && echo "    copied $f"
    fi
  done
else
  echo "    SUPERSET_ROOT_PATH not set; skipping"
fi

echo "==> Creating virtualenv (.venv)"
if [ ! -x .venv/bin/python ]; then
  # Django 4.2 supports Python 3.8-3.12.
  PY=""
  for c in python3.12 python3.11 python3.10 python3; do
    if command -v "$c" >/dev/null 2>&1; then PY="$c"; break; fi
  done
  "$PY" -m venv .venv
fi

echo "==> Installing Python dependencies"
.venv/bin/pip install --quiet --upgrade pip
# mysqlclient is only needed with USE_MYSQL (docker/prod); local dev uses
# sqlite, so install it best-effort since it needs a native MySQL client lib.
grep -hv '^mysqlclient' requirements.txt > .venv/requirements-local.txt
grep -v '^-r' requirements-dev.txt >> .venv/requirements-local.txt
.venv/bin/pip install --quiet -r .venv/requirements-local.txt
.venv/bin/pip install --quiet mysqlclient >/dev/null 2>&1 \
  || echo "    (mysqlclient not installed; fine unless you set USE_MYSQL)"

echo "==> Reserving dev-server port"
PORT=$(allocate_port)
echo "    this workspace will serve on http://127.0.0.1:$PORT"

echo "==> Setup complete"
