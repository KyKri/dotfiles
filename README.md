# dotfiles

Personal dotfiles repo with a small install/uninstall system and OS bootstraps.

## Layout
- `config/` holds app configs (linked into `~/.config`).
- `home/` holds files that live directly in `$HOME` (e.g. `.zshrc`, `.gitconfig`).
- `scripts/` includes platform bootstrap scripts.

## Install
```sh
./install.sh
```

## Uninstall (optional)
```sh
./uninstall.sh
```

## Bootstrap
```sh
./scripts/bootstrap_macos.sh
./scripts/bootstrap_ubuntu.sh
./scripts/bootstrap_arch.sh
```

## tmux
Config lives at `home/.tmux.conf` and is linked to `~/.tmux.conf`.

## iTerm2 (macOS only)
Place exported iTerm2 preferences in `config/iterm2/`. These are linked on macOS installs only.
