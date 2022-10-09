local packageName = "catppuccin/nvim"

local config = function()
  vim.g.catppuccin_flavour = "mocha"
  require("catppuccin").setup()
  vim.api.nvim_command("colorscheme catppuccin")
end

return {
  packageName,
  config = config,
}
