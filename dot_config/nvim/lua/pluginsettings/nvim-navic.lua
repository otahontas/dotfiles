local packageName = "SmiteshP/nvim-navic"

local requires = {
  "neovim/nvim-lspconfig",
}

local config = function()
  local navic = require("nvim-navic")

  require("lualine").setup({
    sections = {
      lualine_c = {
        { navic.get_location, cond = navic.is_available },
      },
    },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "250d89085a69688157864201b533ee0581eb6a83",
}
