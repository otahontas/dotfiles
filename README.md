# Dotfiles

This repo includes my configurations for macOS

## Highlights

- Common color schemes:
  - [Edge light](https://github.com/sainnhe/edge) is the main theme, used in various programs. Since the main theme is very bright and light (I know, crazyyyy), many TUIs and CLI tools have been configured to look great with white bg.
- Installation scripts:
  - Semi-automated installation script for MacOS (Setup Assistant needs to be run first)
- Templated dotfiles:
  - [Chezmoi](https://www.chezmoi.io/) for dotfiles management
- Fast terminal experience:
  - [Alacritty](https://alacritty.org/) terminal emulator
  - [Zsh shell](https://www.zsh.org/) with [antibody plugin manager](https://getantibody.github.io/), [powerlevel10k theme](https://github.com/romkatv/powerlevel10k) and a bunch of useful plugins
  - [tmux](https://github.com/tmux/tmux) for terminal multiplexing in servers
  - [fzf](https://github.com/junegunn/fzf) (with fd and ripgrep) command-line fuzzy
    finder for searching and opening files by name/content, folders, apps etc.
  - [GPG](https://gnupg.org/) -subkey based SSH auth
- Configs for text-based user interfaces (TUIs):
  - [Neovim](https://neovim.io/) with IDE-style editing experience, neovim 0.5 needed, works great in servers too
  - [Aerc](https://aerc-mail.org/) email client
  - [Pass](https://www.passwordstore.org/) for passwords
  - [Spotify-tui](https://github.com/Rigellute/spotify-tui) and [spotifyd](https://github.com/Spotifyd/spotifyd)
    for spotify
  - [Newsboat](https://newsboat.org/) for RSS
  - [GitUI](https://github.com/extrawurst/gitui) for git when basic `git log` is not enough
  - [Dasht](https://github.com/sunaku/dasht) for api docs
  - [Glow](https://github.com/charmbracelet/glow) for reading markdown
- I do also use following of great gui tools on macOS:
  - [Amethyst](https://github.com/ianyh/Amethyst) for tiling window management

## (Fresh) Installation

- Prepare:
  - Cleanup any previous install
  - Set up firware password
- Run graphical setup:
  - Clear NVRAM
  - Make your way through Setup Assistant
- Open terminal and run installation script with `bash <(curl -sL https://git.io/Jq9ln)`

## Generic todo:
- add offlineimap
- add notmuch
- add sync for calendar & contacts
- add khal & khard
- add khard as addressbook source to aerc
- add confs for gui programs
- convert install script to "no-script" / add more prompts, don't just install everything
