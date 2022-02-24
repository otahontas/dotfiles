local utils = require("utils")
local create_autogroup = utils.create_autogroup
local map = utils.map

-- Show matching brackets
vim.opt.showmatch = true

-- Highlight line where cursor is
vim.opt.cursorline = true

-- Show current line as absolute and other as relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Set up different line number settings for different modes
create_autogroup("DisableNumberInTerminal", {
  "TermOpen * startinsert",
  "TermOpen * :set nonumber norelativenumber"
})
create_autogroup("ChangeNumberModeOnWritingModeChange", {
  "BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != 'i' | set relativenumber | endif",
  "BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif"
})

-- Show line break column & all columns too far to the right
vim.cmd("let &colorcolumn=\"88,\".join(range(120, 999),\",\")")

-- Set different color for terminal mode cursor
vim.cmd("highlight! link TermCursor Cursor")
vim.cmd("highlight! TermCursorNC guibg=blue guifg=white ctermbg=1 ctermfg=15")

-- Try to autoindent when adding a new line
vim.opt.smartindent = true

-- Always expand tabs to spaces
vim.opt.expandtab = true

-- Set basic indent to be 4 spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Make hard line break on 88
vim.opt.textwidth = 88

-- Ignore case normally, but override ignoring if search contains upper chars
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Write backup files, but not to the same directory as the original file
vim.opt.backup = true
vim.opt.backupdir:remove({"."})

-- Always use UTF-8
vim.opt.fileencoding = "utf-8"

-- Disable annoying bell
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Lower the time vim waits for a key code seq to complete
vim.opt.timeoutlen=500

-- Lower the time when swap file is written to the disk
vim.opt.updatetime=300

-- Read changes from outside world
vim.opt.autoread = true
create_autogroup("TriggerAutoRead", {
  "FocusGained, BufEnter, CursorHold, CursorHoldI * if mode() != 'c' | checktime | endif"
})
create_autogroup("TriggerAutoReadMessage", {
  "FileChangedShellPost * echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None"
})

-- Set up leader and localleader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Set up hidden chars to show on toggle
vim.opt.listchars = {nbsp = "¬", eol = "¶", tab = ">-", extends = "»", precedes = "«", trail = "•"}

-- Set some extra diff-heuristics: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append({"indent-heuristic", "algorithm:patience"})

-- Load remaps
require("core.remaps")
