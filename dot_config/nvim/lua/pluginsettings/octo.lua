local packageName = "pwntester/octo.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "kyazdani42/nvim-web-devicons",
}

local config = function()
  require("octo").setup()
end

return { packageName, requires = requires, config = config }
