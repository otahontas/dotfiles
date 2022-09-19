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
}
