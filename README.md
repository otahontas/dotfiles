<h1 align="center"> Dotfiles ❤ </h1>

Configuration for Arch Linux, zsh, sway, kitty, nvim and more.

![example screenshot](https://raw.githubusercontent.com/otahontas/dotfiles/master/screenshot.png)

## Goals
- Simple and good-looking design choices
- Keep files quite minimal and well-documented, so setup is easy to debug and stays fast
- Use XDG Base Directories as much as possible
- Prefer cli tools and Wayland compatibility 
- Allow easy setup on new computers

## Important programs
- CLI:
    - Shell: Zsh with Antibody plugin manager and Powerlevel10K theme
    - Editor: Nvim with language-server support from coc
    - Multiplexer: Tmux
    - Version control: Git
    - Fuzzy finder: Fzf
    - File manager: Ranger
    - Worth of mentioning cli apps: aerc & offlineimap (mails), khal & khard & vdirsyncer (calendars&contacts), pass (passwords), spotify-tui & spotifyd (Spotify), s (web search launcher), syncthing (sync) and duplicity (backups)
- GUI:
    - Window manager: Sway
    - Terminal/app launcher/file launcher: Kitty
    - Browser: Firefox Dev edition
    - Colorscheme is [Rigel](https://rigel.netlify.com/) and is implemented in Kitty, Neovim, Sway and Bemenu. GTK-theme (for e.g. Firefox) is Arc-Dark.
    - Fonts are [FiraCode](https://github.com/tonsky/FiraCode) for coding and terminal, [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k) for added bunch of Glyphs and ttf-dejavu as base-level fonts.

## Installation
- Clone repo into $HOME/.config or merge with your existing config 
- Symlink pam_environment_arch to $HOME/.pam_environment or set up environmental variables some other way
- Reboot
- Run symlink scripts
- For whole Arch OS (+optionally Win 10 dual-boot) installation, check out [ARCH_INSTALL.md](https://github.com/otahontas/dotfiles/blob/master/ARCH_INSTALL.md)
