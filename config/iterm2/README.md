iTerm2 config placeholder (v3.6.6).

In iTerm2 3.6.6:
1) Open iTerm2 > Settings (or Preferences).
2) General > Settings.
3) Enable “Load preferences from a custom folder or URL”.
4) Choose this folder: ~/.config/iterm2
5) Click “Save Settings to Folder” (or the save button) to export.

Place the exported files here and re-run ./install.sh on macOS.

Export existing settings:
1) Open iTerm2 > Settings (or Preferences).
2) General > Settings.
3) Click “Save Settings to Folder” to write the current preferences into the chosen folder.
4) Verify files exist in ~/.config/iterm2 (for this repo, that path is linked to config/iterm2).

Install JetBrainsMono Nerd Font Mono:
1) If you use the Brewfile, run `./scripts/bootstrap_macos.sh` to install the font via Homebrew.
2) Or download “JetBrainsMono Nerd Font Mono” from Nerd Fonts and install the .ttf files.
3) In iTerm2 > Settings > Profiles > Text, set Font to “JetBrainsMono Nerd Font Mono”.
