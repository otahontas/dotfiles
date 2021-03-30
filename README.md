# Dotfiles

This repo includes my configurations for macOS and arch/ubuntu servers. 

## Highlights

- Common color schemes:
  - [Edge light](https://github.com/sainnhe/edge) is the main theme, used in various programs. Since the main theme is very bright and light (I know, crazyyyy), many TUIs and CLI tools have been configured to look great with white bg.
- Installation scripts:
  - Automated installation script for Arch Linux homeserver, with self-signed secure boot keys
  - Semi-automated installation script for MacOS (Setup Assistant needs to be run first)
- Templated dotfiles:
  - [Chezmoi](https://www.chezmoi.io/) for dotfiles management
- Fast terminal experience:
  - [Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator with ligature and modern graphics / true-color support
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
- I do also use following of great gui tools on macOS:
  - [Amethyst](https://github.com/ianyh/Amethyst) for tiling window management
  - [Insomnia](https://github.com/Kong/insomnia) api client for rest / graphql stuff
  - [Iina](https://github.com/iina/iina) video player
  - [Karabiner-Element](https://karabiner-elements.pqrs.org/) for custom keyboard bindings (such as binding right shift as hyper key) and shortcuts
  - [KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake) to keep mac awake when needed
  - [Spotter](https://github.com/ziulev/spotter) launcher to replace spotlight
  - [Stretchly](https://github.com/hovancik/stretchly) to remind me to take breaks when working
  - [Tunnelblick](https://tunnelblick.net/) for VPN
  - [Turbo Boost Switcher](https://github.com/hovancik/stretchly) to toggle turbo boost on demand

## (Fresh) Installation

**Arch Linux**:

- Download ISO and create bootable USB with `dd if=archlinux*.iso of=/dev/sdX && sync`
- Prepare UEFI:
  - Set boot mode to only UEFI, i.e. disable legacy mode
  - Disable secure boot
  - Add strong UEFI admin password
  - Delete preloaded OEM keys for Secure Boot, allow custom ones
- Run installation:
  - Boot to Arch live usb
  - Connect to internet
  - Run installation script with `bash <(curl -sL https://git.io/Jq9ld)`
  - Reboot and enable secure boot
  - Finish installation according to installation script

**macOS**:

- Prepare:
  - Cleanup any previous install
  - Set up firware password
- Run graphical setup:
  - Clear NVRAM
  - Make your way through Setup Assistant
- Open terminal and run installation script with `bash <(curl -sL https://git.io/Jq9ln)`
