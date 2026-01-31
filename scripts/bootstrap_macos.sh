#!/usr/bin/env sh
set -eu

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install from https://brew.sh and re-run."
  exit 1
fi

if [ -f "$(dirname -- "$0")/../Brewfile" ]; then
  brew bundle --file="$(dirname -- "$0")/../Brewfile"
fi

printf 'macOS bootstrap complete.\n'
