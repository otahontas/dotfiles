-- Use current neovim instance as preferred text editor if possible
vim.cmd(
  "if executable('nvr') | let $VISUAL=\"nvr -cc split --remote-wait +'set bufhidden=wipe'\" | endif"
)
