local packageName = "kosayoda/nvim-lightbulb"

local config = function()
  vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
  require("nvim-lightbulb").setup()
end

return { packageName, config = config }
