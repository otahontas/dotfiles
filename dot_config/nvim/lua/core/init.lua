local utils = require("utils")
local create_autogroup = utils.create_autogroup

-- disable netrw at the very start of your init.lua (strongly advised in nvim-tree docs)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Setup options
local options = {
  -- Enable better colors
  termguicolors = true,
  -- Show sign column always,
  signcolumn = "yes",
  -- Show matching brackets
  showmatch = true,
  -- Highlight line where cursor is
  cursorline = true,
  -- Show current line as absolute and other as relative
  number = true,
  relativenumber = true,
  -- Try to autoindent when adding a new line
  smartindent = true,
  -- Always expand tabs to spaces
  expandtab = true,
  -- Set basic indent to be 4 spaces
  shiftwidth = 4,
  softtabstop = 4,
  tabstop = 4,
  -- Make hard line break on 88
  textwidth = 88,
  -- Ignore case normally, but override ignoring if search contains upper chars
  ignorecase = true,
  smartcase = true,
  -- Write backup files
  backup = true,
  -- Always use UTF-8
  fileencoding = "utf-8",
  -- Disable annoying bell
  errorbells = false,
  visualbell = false,
  -- Use system clipboard
  clipboard = "unnamedplus",
  -- Lower the time vim waits for a key code seq to complete
  timeoutlen = 500,
  -- Lower the time when swap file is written to the disk
  updatetime = 300,
  -- Use global statusline
  laststatus = 3,
  -- Read changes from outside world
  autoread = true,
  -- Set up hidden chars to show on toggle
  listchars = {
    nbsp = "¬",
    eol = "¶",
    tab = ">-",
    extends = "»",
    precedes = "«",
    trail = "•",
  },
  -- Spellcheck
  spell = true,
}
for option, value in pairs(options) do
  vim.opt[option] = value
end

-- Set up leader and localleader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Set up different line number settings for different modes
create_autogroup("DisableNumberInTerminal", {
  "TermOpen * setlocal nonumber norelativenumber",
})
create_autogroup("ChangeNumberModeOnWritingModeChange", {
  "BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != 'i' | setlocal relativenumber | endif",
  "BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | setlocal norelativenumber | endif",
})

-- Setup listeners for autoread events
create_autogroup("TriggerAutoRead", {
  "FocusGained, BufEnter, CursorHold, CursorHoldI * if mode() != 'c' | checktime | endif",
})
create_autogroup("TriggerAutoReadMessage", {
  "FileChangedShellPost * echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- Show line break column
vim.cmd('let &colorcolumn="88"')

-- Set different color for terminal mode cursor
vim.cmd("highlight! link TermCursor Cursor")
-- vim.cmd("highlight! TermCursorNC guibg=blue guifg=white ctermbg=1 ctermfg=15")

-- Don't put backups to the same directory as original file
vim.opt.backupdir:remove({ "." })

-- Set some extra diff-heuristics: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })

-- Load remaps
require("core.remaps")
