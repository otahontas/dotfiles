local packageName = "kyazdani42/nvim-tree.lua"

local requires = { "kyazdani42/nvim-web-devicons", opt = true }

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

  local keymap_opts = { silent = true }
  vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>en", "<cmd>NvimTreeFindFile<CR>", keymap_opts)
end

return {
  packageName,
  requires = requires,
  config = config,
}
