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
  commit = "67bddeca28c476731ed5da64876b7f71d01190d1",
}
