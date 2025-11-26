#!/usr/bin/env bash
set -euo pipefail

if command -v apt-get >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y --no-install-recommends fish
elif command -v dnf >/dev/null 2>&1; then
  dnf install -y fish
elif command -v apk >/dev/null 2>&1; then
  apk add --no-cache fish
else
  echo "Package manager not supported for fish install."
  exit 1
fi

echo "Fish installed at: $(command -v fish || true)"
