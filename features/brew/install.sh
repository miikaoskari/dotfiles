#!/usr/bin/env bash
set -euo pipefail

export NONINTERACTIVE=1
bash "$(dirname "$0")/brew"
