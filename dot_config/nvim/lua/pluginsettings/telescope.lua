local utils = require("utils")
local map = utils.map

-- Shortcuts for different modes
local base = "<cmd>lua require('telescope.builtin')."

--- Open generic
map("n", "<leader>tt", base .. "builtin()")

-- Neovim internals
map("n", "<leader>bb", base .. "buffers()")
map("n", "<leader>ch", base .. "command_history()")
map("n", "<leader>km", base .. "keymaps()")
map("n", "<leader>rr", base .. "registers()")

-- Files
map("n", "<leader>ff", base .. "find_files()")
map("n", "<leader>of", base .. "old_files()")
map("n", "<leader>rg", base .. "live_grep()")

-- LSP Pickers
map("n", "gd", base .. "lsp_definitions()")
map("n", "gr", base .. "lsp_references()")

local packageName = "nvim-telescope/telescope.nvim"

local requires = {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
}

local config = function()
  local telescope = require("telescope")

  telescope.load_extension("fzf")

  local options = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        -- from: https://github.com/nvim-telescope/telescope.nvim/blob/c92f86386f8446e4deaa79941baabaf825683be9/lua/telescope/config.lua#L631
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        -- extra additions
        "--follow",
        "--hidden",
        "--trim",
      },
    },
    pickers = {
      find_files = {
        -- match with fzf default
        find_command = { "fd", "--type", "file", "--strip-cwd-prefix", "--hidden" },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
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
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "30e2dc5232d0dd63709ef8b44a5d6184005e8602",
}
