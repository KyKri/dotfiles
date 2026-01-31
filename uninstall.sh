#!/usr/bin/env sh
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

unlink_file() {
  src="$1"
  dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    rm "$dest"
    if [ -e "${dest}.bak" ]; then
      mv "${dest}.bak" "$dest"
    fi
  fi
}

# Unlink config/ from ~/.config
for dir in nvim zsh git tmux; do
  find "$REPO_DIR/config/$dir" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
    | while IFS= read -r -d '' path; do
        base=$(basename "$path")
        unlink_file "$path" "$HOME/.config/$dir/$base"
      done
done

if [ "$(uname -s)" = "Darwin" ]; then
  find "$REPO_DIR/config/iterm2" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
    | while IFS= read -r -d '' path; do
        base=$(basename "$path")
        unlink_file "$path" "$HOME/.config/iterm2/$base"
      done
fi

# Unlink home/ from ~
find "$REPO_DIR/home" -mindepth 1 -maxdepth 1 -print0 2>/dev/null \
  | while IFS= read -r -d '' path; do
      base=$(basename "$path")
      unlink_file "$path" "$HOME/$base"
    done

printf 'Uninstalled dotfiles. Restored .bak files when present.\n'
