#!/usr/bin/env bash
set -euo pipefail

touch /run/.containerenv

export NONINTERACTIVE=1
bash "$(dirname "$0")/brew"
