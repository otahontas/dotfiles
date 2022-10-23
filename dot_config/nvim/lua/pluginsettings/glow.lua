local packageName = "ellisonleao/glow.nvim"

local config = function()
  require("glow").setup({
    border = "rounded",
  })
end

return { packageName, config = config }
