local packageName = "projekt0n/github-nvim-theme"

local config = function()
  require("github-theme").setup({
    theme_style = "light_default",
    dark_sidebar = false,
  })
end

return {
  packageName,
  config = config,
}
