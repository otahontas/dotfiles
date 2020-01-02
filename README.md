# Dotfiles
Configuration for Arch Linux, zsh, sway, kitty, neovim and more. These files currently live in my ~/.config -folder on different computers.

## Goals
- Simple and good-looking design choices:
    - Current colorscheme is [Rigel](https://rigel.netlify.com/)
    - Fonts are:
        - [FiraCode](https://github.com/tonsky/FiraCode) for coding and terminal
        - [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k) for added bunch of Glyphs
        - Google Noto fonts and Google Noto emoji font as base-level fonts
- Keep files quite minimal, so it's easy to debug and stays fast
- Keep files well-documented
- Use XDG Base Directories as much as possible
- Prefer cli tools and Wayland compatibility 
    - Current pacman and aur installed software can be found from [packages](tree/master/packages)
- Allow easy setup on new computers with (upcoming) script
