local packageName = "kosayoda/nvim-lightbulb"

local requires = {
  "antoinemadec/FixCursorHold.nvim",
}

local config = function()
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "1e2844b68a07d3e7ad9e6cc9a2aebc347488ec1b",
}
