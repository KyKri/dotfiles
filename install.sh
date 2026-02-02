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

ensure_git_identity() {
  git_identity_file="$HOME/.gitconfig.local"
  if [ -f "$git_identity_file" ]; then
    return 0
  fi

  if [ ! -t 0 ]; then
    printf 'Skipping git identity prompt (no TTY). Create %s manually.\n' "$git_identity_file"
    return 0
  fi

  printf 'Git user name: '
  read -r git_name
  printf 'Git user email: '
  read -r git_email

  if [ -z "$git_name" ] || [ -z "$git_email" ]; then
    printf 'Skipping git identity setup (missing name or email). Create %s manually.\n' "$git_identity_file"
    return 0
  fi

  {
    printf '[user]\n'
    printf '  name = %s\n' "$git_name"
    printf '  email = %s\n' "$git_email"
  } >"$git_identity_file"
}

mkdir -p "$HOME/.config"

is_macos=false
if [ "$(uname -s)" = "Darwin" ]; then
  is_macos=true
fi

# Link config/ -> ~/.config
for dir in nvim git; do
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

ensure_git_identity

printf 'Installed dotfiles. Backups use the .bak suffix.\n'
