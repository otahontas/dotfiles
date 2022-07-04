local utils = require("utils")
local map = utils.map

local packageName = "tpope/vim-fugitive"

map("n", "<leader>G", ":G ", { silent = false, suffix = "" })

return {
  packageName,
  commit = "f809dde0e719f89a6fb5cb80f3be65f5cbc1d1fe",
}
