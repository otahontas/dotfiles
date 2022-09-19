local utils = require("utils")
local map = utils.map

-- Set up keybindings
map("n", "<leader>ee", ":NvimTreeToggle")
map("n", "<leader>er", ":NvimTreeRefresh")
map("n", "<leader>en", ":NvimTreeFindFile")

local packageName = "kyazdani42/nvim-tree.lua"

local requires = { "kyazdani42/nvim-web-devicons" }

local config = function()
  require("nvim-tree").setup({
    disable_netrw = true,
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    git = {
      ignore = false,
    },
    view = {
      width = 50,
      side = "right",
    },
    renderer = {
      highlight_opened_files = "icon",
    },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
}
