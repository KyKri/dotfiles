#!/usr/bin/env sh
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

link_file() {
  src="$1"
  dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$(readlink "$dest" 2>/dev/null || true)" = "$src" ]; then
      return 0
    fi
    mv "$dest" "${dest}.bak"
  fi

  ln -s "$src" "$dest"
}

mkdir -p "$HOME/.config"

is_macos=false
if [ "$(uname -s)" = "Darwin" ]; then
  is_macos=true
fi

# Link config/ -> ~/.config
for dir in nvim zsh git; do
  mkdir -p "$HOME/.config/$dir"
  find "$REPO_DIR/config/$dir" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
    | while IFS= read -r -d '' path; do
        base=$(basename "$path")
        link_file "$path" "$HOME/.config/$dir/$base"
      done
done

if $is_macos; then
  mkdir -p "$HOME/.config/iterm2"
  find "$REPO_DIR/config/iterm2" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
    | while IFS= read -r -d '' path; do
        base=$(basename "$path")
        link_file "$path" "$HOME/.config/iterm2/$base"
      done
fi

# Link home/ -> ~
find "$REPO_DIR/home" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
  | while IFS= read -r -d '' path; do
      base=$(basename "$path")
      link_file "$path" "$HOME/$base"
    done

printf 'Installed dotfiles. Backups use the .bak suffix.\n'
