local packageName = "sainnhe/edge"

local config = function()
  vim.opt.background = "light"
  vim.cmd("colorscheme edge")
end

return { packageName, config = config }
