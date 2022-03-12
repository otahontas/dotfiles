local packageName = "nvim-treesitter/nvim-treesitter"

local requires = {
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "RRethy/nvim-treesitter-endwise",
}

local run = ":TSUpdate"

local config = function()
  local options = {
    ensure_installed = "maintained",
    -- Highlighting fails on multi-part tex documents, otherwise enable
    highlight = { enable = true, disable = { "latex" } },
    indent = { enable = true },
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

return { packageName, requires = requires, run = run, config = config }
