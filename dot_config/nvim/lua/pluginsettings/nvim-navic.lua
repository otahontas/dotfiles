local packageName = "SmiteshP/nvim-navic"

local requires = {
  "neovim/nvim-lspconfig",
}

local config = function()
  local navic = require("nvim-navic")

  -- TODO: move this to winbar when 0.8 is released
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
}
