local packageName = "SmiteshP/nvim-gps"

local requires = {
  "nvim-treesitter/nvim-treesitter",
}

local config = function()
  local gps = require("nvim-gps")
  gps.setup()

  require("lualine").setup({
    sections = {
      lualine_c = {
        { gps.get_location, cond = gps.is_available },
      },
    },
  })
end

return { packageName, requires = requires, config = config }

-- TODO: replace
