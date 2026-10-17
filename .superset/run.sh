#!/usr/bin/env bash
# Launch the Django dev server on this workspace's reserved port.
set -euo pipefail
cd "$(dirname "$0")/.."
source .superset/ports.sh

PORT=$(allocate_port)
echo "Starting Django dev server on http://127.0.0.1:$PORT"
echo $$ > "$PID_FILE"
exec .venv/bin/python manage.py runserver "0.0.0.0:$PORT"
