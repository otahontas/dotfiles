local packageName = "hoob3rt/lualine.nvim"

local requires = { "kyazdani42/nvim-web-devicons" }

local config = function()
  local options = { theme = "onelight" }
  local extensions = { "nvim-tree" }
  require("lualine").setup({
    options = options,
    extensions = extensions,
  })
end

return { packageName, requires = requires, config = config }
