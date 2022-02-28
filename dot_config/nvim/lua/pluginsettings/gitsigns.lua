local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  require("gitsigns").setup({ current_line_blame = true })
end

return { packageName, requires = requires, config = config }
