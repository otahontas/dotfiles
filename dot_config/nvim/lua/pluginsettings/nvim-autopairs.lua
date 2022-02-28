local packageName = "windwp/nvim-autopairs"

local config = function()
  require("nvim-autopairs").setup()
end

return { packageName, config = config }
