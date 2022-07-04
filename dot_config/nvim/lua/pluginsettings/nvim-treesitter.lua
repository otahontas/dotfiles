local packageName = "nvim-treesitter/nvim-treesitter"

local requires = {
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "RRethy/nvim-treesitter-endwise",
}

local run = ":TSUpdate"

local config = function()
  local options = {
    ensure_installed = "all",
    -- Highlighting fails on multi-part tex documents, otherwise enable
    highlight = { enable = true, disable = { "latex" } },
    -- Indenting is weird for go
    indent = { enable = true, disable = { "go" } },
    rainbow = { enable = true, extended_mode = true },
    autotag = { enable = true },
    endwise = { enable = true },
  }
  require("nvim-treesitter.configs").setup(options)

  -- Use treesitter to handle folding
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"

  -- Start always with all folds open
  vim.o.foldlevelstart = 20
end

return {
  packageName,
  requires = requires,
  run = run,
  config = config,
  commit = "f75e27c2170ef4cc83cc9fa10a82c84ec82f5021",
}
