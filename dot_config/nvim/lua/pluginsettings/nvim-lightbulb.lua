local packageName = "kosayoda/nvim-lightbulb"

local config = function()
  vim.cmd(
    [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  )
  require("nvim-lightbulb").setup()
end

return {
  packageName,
  config = config,
  commit = "1e2844b68a07d3e7ad9e6cc9a2aebc347488ec1b",
}
