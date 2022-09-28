local packageName = "nvim-treesitter/nvim-treesitter"

local requires = {
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "RRethy/nvim-treesitter-endwise",
  "m-demare/hlargs.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",
}

local run = ":TSUpdate"

local config = function()
  local options = {
    ensure_installed = {
      "bash",
      "bibtex",
      "c",
      "comment",
      "cpp",
      "css",
      "dockerfile",
      "gitattributes",
      "gitignore",
      "go",
      "gomod",
      "graphql",
      "haskell",
      "help",
      "html",
      "http",
      "javascript",
      "jsdoc",
      "json",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rst",
      "rust",
      "sql",
      "todotxt",
      "toml",
      "typescript",
      "vim",
      "yaml",
    },
    -- Install parsers listed in ensure_installed synchronousl
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    -- Highlighting fails on multi-part tex documents, otherwise enable
    highlight = { enable = true, disable = { "latex" } },
    -- Indenting is weird for yaml
    indent = { enable = true, disable = { "yaml" } },
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

  -- Allow treesitter context
  require("treesitter-context").setup()

  -- add better highlight group (from gh theme)
  vim.cmd("highlight TreesitterContext guibg=#e1e4e8")
end

return {
  packageName,
  requires = requires,
  run = run,
  config = config,
}
