local packageName = "stevearc/aerial.nvim"

local requires = {
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
}

local config = function()
  require("aerial").setup()
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "bd6de885a03df4b4fe9d2cadb5e4674a2bdf5cd3",
}
