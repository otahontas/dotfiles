<h1 align="center"> Dotfiles ❤ </h1>

Configuration for Arch Linux, zsh, sway, kitty, neovim and more.

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
    - Editor: Neovim with bunch of plugins mimicking IDE style configurations
    - Multiplexer: Tmux
    - Version control: Git
    - Fuzzy finder: Fzf
    - File manager: Ranger
    - Worth of mentioning cli apps: aerc & hydroxide (mails), khal & khard & vdirsyncer (calendars&contacts), pass (passwords), spotify-tui & spotifyd (Spotify), s (web search launcher), syncthing (sync) and duplicity (backups)
- GUI:
    - Window manager: Sway
    - App launcher: Wofi
    - Terminal: Kitty
    - Browser: Firefox Dev edition
    - Colorscheme is [Rigel](https://rigel.netlify.com/) and is implemented in Kitty, Neovim, Sway and Bemenu. GTK-theme (e.g. for Firefox) is Arc-Dark.
    - Fonts are [FiraCode](https://github.com/tonsky/FiraCode) for coding and terminal, [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k) for added bunch of Glyphs and Google Noto fonts (including noto-emojis) as base-level fonts.

## Installation
- Clone repo into $HOME/.config
- Execute installation_scripts/create_pam_symlink.sh or copy/symlink .pam_enviroment to $HOME
- Reboot
- Execute installation_scripts/install_dotfiles.sh
- For whole Arch OS (+optionally Win 10 dual-boot) installation, check out [ARCH_INSTALL.md](https://raw.githubusercontent.com/otahontas/dotfiles/ARCH_INSTALL.md)
