local utils = require("utils")
local create_autogroup = utils.create_autogroup

vim.opt.termguicolors = true
vim.opt.background = "light"
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.textwidth = 88
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backup = true
vim.opt.backupdir = "~/.local/share/nvim/backup//"
vim.opt.fileencoding = "utf-8"
vim.opt.wildignore = {"*.o","*~","*.pyc","*/.git/*","*/.hg/*","*/.svn/*","*/.DS_Store"}
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.timeoutlen=500
vim.opt.updatetime=300
vim.opt.autoread = true
vim.opt.listchars = {nbsp = "¬", eol = "¶", tab = ">-", extends = "»", precedes = "«", trail = "•"}
vim.opt.diffopt:append({"indent-heuristic", "algorithm:patience"})

vim.cmd("colorscheme edge")
vim.cmd("highlight! link TermCursor Cursor")
vim.cmd("highlight! TermCursorNC guibg=blue guifg=white ctermbg=1 ctermfg=15")
vim.cmd("if empty(glob('$XDG_DATA_HOME/nvim/backup/')) | silent !mkdir -p $XDG_DATA_HOME/nvim/backup | endif")
vim.cmd("if executable('nvr') | let $VISUAL=\"nvr -cc split --remote-wait +'set bufhidden=wipe'\" | endif")

create_autogroup("DisableNumberInTerminal", {
  "TermOpen * startinsert",
  "TermOpen * :set nonumber norelativenumber"
})

create_autogroup("ChangeNumberModeOnWritingModeChange", {
  "BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != 'i' | set relativenumber | endif",
  "BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif"
})

create_autogroup("AutoApplyChezmoi", {
  "BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %"
})

create_autogroup("ChangeChezmoiTemplateFiletypes", {
  "BufNewFile,BufRead ~/local/share/chezmoi/**/*.tmpl let &filetype = expand('%:r:e')"
})

create_autogroup("TriggerAutoRead", {
  "FocusGained, BufEnter, CursorHold, CursorHoldI * if mode() != 'c' | checktime | endif"
})

create_autogroup("TriggerAutoReadMessage", {
  "FileChangedShellPost * echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None"
})
