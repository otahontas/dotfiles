local packageName = "SmiteshP/nvim-navic"

local requires = { "neovim/nvim-lspconfig", "hoob3rt/lualine.nvim" }

local after = {
  "nvim-lspconfig",
  "lualine.nvim",
}

local config = function()
  local navic = require("nvim-navic")
  local lualine = require("lualine")
  lualine.setup({
    winbar = {
      lualine_b = {
        { navic.get_location, cond = navic.is_available },
      },
    },
  })
end

return {
  packageName,
  requires = requires,
  after = after,
  config = config,
}
