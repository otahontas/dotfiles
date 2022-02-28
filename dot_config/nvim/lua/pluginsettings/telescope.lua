local utils = require("utils")
local map = utils.map

-- Shortcuts for different modes
local base = "<cmd>lua require('telescope.builtin')."

--- Open generic
map("n", "<leader>tt", base .. "builtin()")

-- Neovim internals
map("n", "<leader>bb", base .. "buffers()")
map("n", "<leader>hh", base .. "command_history()")
map("n", "<leader>ma", base .. "keymaps()")
map("n", "<leader>rr", base .. "registers()")

-- Files
map("n", "<leader>ff", base .. "find_files()")
map("n", "<leader>rg", base .. "live_grep()")

-- LSP Pickers
map("n", "ca", base .. "lsp_code_actions()")
map("v", "ca", base .. "lsp_range_code_actions()")
map("n", "gd", base .. "lsp_definitions()")
map("n", "gr", base .. "lsp_references()")
map("n", "ge", base .. "lsp_document_diagnostics()")
map("n", "we", base .. "lsp_workspace_diagnostics()")
map("n", "ds", base .. "lsp_document_symbols()")

local packageName = "nvim-telescope/telescope.nvim"

local requires = {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
}

local config = function()
  local telescope = require("telescope")
  local options = {
    defaults = {
      file_ignore_patterns = {
        ".git/",
        "node_modules",
      },
      vimgrep_arguments = {
        "rg",
        "--ignore",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    extensions = {
      dash = {
        file_type_keywords = {
          javascript = { "javascript", "nodejs" },
          typescript = { "typescript", "javascript", "nodejs" },
          typescriptreact = { "typescript", "javascript", "react" },
          javascriptreact = { "javascript", "react" },
        },
      },
    },
  }
  telescope.setup(options)
  telescope.load_extension("fzf")
end

return {
  packageName,
  requires = requires,
  config = config,
}
