# Dotfiles

This repo includes my configurations for macOS. I used to keep here a list of highlights such as what is terminal I use, but it was always out of sync. Guess I change my mind too often ¯\_(ツ)_/¯

Feel free to sniff around.

## (Fresh) Installation

- Prepare:
  - Cleanup any previous install
  - Set up firware password
- Run graphical setup:
  - Clear NVRAM
  - Make your way through Setup Assistant
- Open terminal and run installation script.

## Generic todo

- change hyper to karabiner + add karabiner config to chezmoi
- port edge-light theme to wezterm
- for some reason scandics aren't working with wezterm, fix
- add global basic packages pyenv & fnm + update scripts for these
- neovim betterments:
  - some git thingys, better PR review process etc., check for files that are going to be committed
  - put all keybindings and autocommands through legendary.nvim
  - add some better typescript things with nvim-lsp-ts-utils
  - add better refactoring with refactoring.nvim
  - sync both above with null-ls
  - add treesitter configs for always working jumps inside functions
  - add workspace errors
  - debugging tools
  - database tools
  - todo.txt
  - <https://github.com/monaqa/dial.nvim>
- add offlineimap & notmuch & some offline-cabable smtp stuff for aerc
- add khal & khard & some way for syncing (vdirsyncer?)
- add khard as addressbook source to aerc
- add confs for all possible gui programs
- convert install script to "no-script" / add more prompts, don't just install everything
