local packageName = "nvim-treesitter/nvim-treesitter"

local requires = {
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "RRethy/nvim-treesitter-endwise",
  "m-demare/hlargs.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
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
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  }
  require("nvim-treesitter.configs").setup(options)

  -- Use treesitter to handle folding
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"

  -- Start always with all folds open
  vim.o.foldlevelstart = 20

  -- Highlight arguments with treesitter
  require("hlargs").setup()
end

return {
  packageName,
  requires = requires,
  run = run,
  config = config,
  commit = "f75e27c2170ef4cc83cc9fa10a82c84ec82f5021",
}
