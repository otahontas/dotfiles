local utils = require("utils")

local packageName = "tpope/vim-fugitive"

vim.keymap.set("n", "<leader>G", ":G ", { silent = false, noremap = true })

return {
  packageName,
}
