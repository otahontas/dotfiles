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
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, disable = { "latex" } },
    indent = { enable = true, disable = { "yaml" } },
    rainbow = { enable = true, extended_mode = true },
    autotag = { enable = true },
    endwise = { enable = true },
    textobjects = {
      select = {
        enable = true,
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
        set_jumps = true,
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
  require("hlargs").setup()
  require("treesitter-context").setup()

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevelstart = 20
end

return {
  packageName,
  requires = requires,
  run = run,
  config = config,
}
