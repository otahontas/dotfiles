local utils = require("utils")

vim.opt_local.spell = true

utils.setIndent(2)
utils.disable_hard_wrap_for_buffer(0)

vim.keymap.set("n", "<leader>ll", function()
  vim.cmd("Glow")
end)
