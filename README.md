<h1 align="center"> Dotfiles ❤ </h1>

Configuration for Arch Linux, zsh, sway, kitty, nvim and more. Managed with [chezmoi](https://www.chezmoi.io/).

![example screenshot](screenshot.png)

## Goals
- Keep setup quite minimal and well-documented
- Use XDG Base Directories as much as possible
- Prefer cli tools and Wayland compatibility

## Important programs
- CLI:
    - shell: zsh with antibody plugin manager and powerlevel10K theme
    - editor: Nnvim
    - fuzzy finder: fzf with fd and ripgrep
    - file manager: ranger
    - mails: aerc & offlineimap
    - calendars & contacts: khal & khard & vdirsyncer
    - passwords: pass
    - spotify: spotify-tui & spotifyd
    - quick web searches: s
    - syncing: syncthing & rsync
    - backups: duplicity
    - notifications: mako
    - screenshots: grim & slurp
    - dotfiles: chezmoi
    - networking: iwd & systemd
- GUI:
    - window manager: sway
    - terminal / app launcher / multiplexer: kitty
    - browser: firefox & firefox dev edition
    - chats: element
    - colorscheme is Atom One, GTK theme is Arc.
    - fonts are [FiraCode](https://github.com/tonsky/FiraCode) for coding and terminal, [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k) for added bunch of glyphs and ttf-dejavu as base-level fonts.

## Installation
- For whole Arch OS (+optionally Win 10 dual-boot) installation guide, check out [installation_guide.md](arch_install/installation_guide.md)
- You probably don't want to install these files directly to your system, but take a look and copy what you like.
