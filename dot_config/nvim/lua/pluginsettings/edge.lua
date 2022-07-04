local packageName = "sainnhe/edge"

local config = function()
  vim.opt.background = "light"
  vim.cmd("colorscheme edge")
end

return {
  packageName,
  config = config,
  commit = "b5f94a1edb63956d3897f60d67d33a64f5f018ae",
}
