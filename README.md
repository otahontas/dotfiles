<h1 align="center"> Dotfiles ❤ </h1>

Configuration for Arch Linux, zsh, sway, kitty, nvim and more. Managed with [chezmoi](https://www.chezmoi.io/).

![example screenshot](screenshot.png)

## Goals
- Keep files quite minimal and well-documented, so setup is easy to debug and stays fast
- Use XDG Base Directories as much as possible
- Prefer cli tools and Wayland compatibility 
- Easy setup on new computers

## Important programs
- CLI:
    - Shell: Zsh (Antibody for plugins, Powerlevel10K theme)
    - Editor: Nvim
    - Multiplexer: Tmux
    - Version control: Git
    - Fuzzy finder: Fzf (with fd and ripgrep)
    - File manager: Ranger
    - Worth of mentioning cli apps: aerc & offlineimap (mails), khal & khard & vdirsyncer (calendars&contacts), pass (passwords), spotify-tui & spotifyd (Spotify), s (web search launcher), syncthing (sync) and duplicity (backups)
- GUI:
    - Window manager: Sway
    - Terminal/app launcher/file launcher: Kitty
    - Browser: Firefox Dev edition
    - Colorscheme is [Rigel](https://rigel.netlify.com/) and is implemented in Kitty, Neovim, Sway and Bemenu. GTK-theme (for e.g. Firefox) is Arc-Dark.
    - Fonts are [FiraCode](https://github.com/tonsky/FiraCode) for coding and terminal, [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k) for added bunch of Glyphs and ttf-dejavu as base-level fonts.

## Installation
- For whole Arch OS (+optionally Win 10 dual-boot) installation guide, check out [installation_guide.md](arch_install/installation_guide.md)
- You probably don't want to install these files directly to your system, but take a look and copy what you like. (If you however want to install these, [chezmoi](https://www.chezmoi.io/docs/how-to/#use-completely-separate-config-files-on-different-machines) can be used.)
