local options = {
  backup = true,
  clipboard = "unnamedplus",
  exrc = true,
  expandtab = true,
  foldlevelstart = 3,
  ignorecase = true,
  laststatus = 3,
  listchars = {
    nbsp = "¬",
    eol = "¶",
    tab = ">-",
    extends = "»",
    precedes = "«",
    trail = "•",
  },
  number = true,
  relativenumber = true,
  shiftwidth = 4,
  showmatch = true,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = 4,
  spell = true,
  splitkeep = "screen",
  tabstop = 4,
  textwidth = 88,
  timeoutlen = 500,
  undofile = true,
  updatetime = 30,
  winborder = "rounded",
}
for option, value in pairs(options) do
  vim.opt[option] = value
end

vim.opt.backupdir:remove({ ".", })

vim.opt.diffopt:append({ "algorithm:patience", })

vim.opt.completeopt = { "fuzzy", "noinsert", "menu", "preinsert", }

vim.diagnostic.config({
  virtual_lines = true,
})
