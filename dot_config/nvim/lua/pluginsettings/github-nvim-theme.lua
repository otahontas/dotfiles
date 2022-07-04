local packageName = "projekt0n/github-nvim-theme"

local config = function()
  require("github-theme").setup({
    theme_style = "light_default",
    comment_style = "italic",
    dark_sidebar = false,
  })
end

return {
  packageName,
  config = config,
  commit = "ce28dbe85ef4eaa3e7d9ae402f448fcc1d87d06d",
}
