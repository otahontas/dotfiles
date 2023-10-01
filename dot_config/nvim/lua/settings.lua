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
  -- Keep stable split when opening another split above / below
  splitkeep = "screen",
  -- persistent undo
  undofile = true

}
-- Setup options
for option, value in pairs(options) do
  vim.opt[option] = value
end

-- Set up leader and localleader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Set up netrw
vim.g.netrw_keepdir = 0 -- avoids some copy bugs
vim.g.netrw_banner = 0 -- don't show manner
vim.g.netrw_liststyle = 3 -- use tree
vim.g.netrw_localcopydircmd = "cp -r" -- recursive copy
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl' -- instead of default nonu (=no number), set line numbers
vim.cmd("highlight! link netrwMarkFile Search") -- highlight marked files 

-- Set different color for terminal mode cursor
vim.cmd("highlight! link TermCursor Cursor")

-- Don't put backups to the same directory as original file
vim.opt.backupdir:remove({ "." })

-- Set some extra diff-heuristics: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })
