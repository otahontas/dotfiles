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
  -- Add treesitter markdown parser to octo buffers
  require("nvim-treesitter.parsers").get_parser_configs().markdown.filetype_to_parsername =
    "octo"
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "1f6a770a3b2a463cff474df51dc037ae7a6c2920",
}
