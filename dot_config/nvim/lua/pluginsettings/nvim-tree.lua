local utils = require("utils")
local map = utils.map

-- Set up keybindings
map("n", "<leader>ee", ":NvimTreeToggle")
map("n", "<leader>er", ":NvimTreeRefresh")
map("n", "<leader>en", ":NvimTreeFindFile")

local packageName = "kyazdani42/nvim-tree.lua"

local requires = { "kyazdani42/nvim-web-devicons" }

local config = function()
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_respect_buf_cwd = 1

  local settings = {
    disable_netrw = true,
    auto_close = true,
    open_on_tab = false,
    open_on_setup = false,
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = true },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    git = {
      ignore = false,
    },
    view = {
      width = 50,
      auto_resize = true,
      side = "right",
      hide_root_folder = true,
    },
  }

  require("nvim-tree").setup(settings)
end

return { packageName, requires = requires, config = config }
