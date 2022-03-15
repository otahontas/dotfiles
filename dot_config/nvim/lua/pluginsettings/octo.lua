local utils = require("utils")
local map = utils.map

local packageName = "pwntester/octo.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "kyazdani42/nvim-web-devicons",
}

--- Open generic
map("n", "<leader>oo", ":Octo", { suffix = "" })

local config = function()
  require("octo").setup()
end

return { packageName, requires = requires, config = config }
