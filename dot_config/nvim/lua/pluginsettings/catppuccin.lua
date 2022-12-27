local packageName = "catppuccin/nvim"

local config = function()
  vim.cmd.colorscheme("catppuccin")
end

return {
  packageName,
  config = config,
}
