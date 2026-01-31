#!/usr/bin/env sh
set -eu

if ! command -v apt-get >/dev/null 2>&1; then
  echo "apt-get not found. This script targets Ubuntu/Debian."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y git neovim

printf 'Ubuntu bootstrap complete.\n'
