local packageName = "ruifm/gitlinker.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  require("gitlinker").setup()
end

return { packageName, requires = requires, config = config }
