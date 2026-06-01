#!/usr/bin/env bash
set -euo pipefail

touch /run/.containerenv

export NONINTERACTIVE=1
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
