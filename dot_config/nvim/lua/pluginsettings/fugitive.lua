local utils = require("utils")
local map = utils.map

local packageName = "tpope/vim-fugitive"

map("n", "<leader>G", ":G ", { silent = false, suffix = "" })

return {
  packageName,
}
