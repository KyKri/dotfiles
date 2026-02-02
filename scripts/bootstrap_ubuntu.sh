#!/usr/bin/env sh
set -eu

if ! command -v apt-get >/dev/null 2>&1; then
  echo "apt-get not found. This script targets Ubuntu/Debian."
  exit 1
fi

sudo apt-get update

# Core tooling for this dotfiles repo and Neovim plugins.
sudo apt-get install -y \
  git \
  neovim \
  curl \
  unzip \
  build-essential \
  python3 \
  python3-pip \
  nodejs \
  npm \
  ripgrep \
  fd-find

# LSP servers available via npm.
sudo npm install -g \
  bash-language-server \
  dockerfile-language-server-nodejs \
  typescript-language-server \
  vscode-langservers-extracted \
  yaml-language-server \
  pyright \
  vim-language-server

# LSP servers that may or may not exist in apt repositories.
apt_lsp_pkgs="lua-language-server helm-ls marksman"
installable=""
missing=""

for pkg in $apt_lsp_pkgs; do
  if apt-cache show "$pkg" >/dev/null 2>&1; then
    installable="$installable $pkg"
  else
    missing="$missing $pkg"
  fi
done

if [ -n "$installable" ]; then
  sudo apt-get install -y $installable
fi

if [ -n "$missing" ]; then
  echo "The following LSP servers were not found in apt and need manual install:"
  echo "$missing"
fi

printf 'Ubuntu bootstrap complete.\n'
