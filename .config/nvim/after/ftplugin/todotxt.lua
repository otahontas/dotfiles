local utils = require("utils")
utils.disable_hard_wrap_for_buffer(0)

-- Spellcheck for markdown files
vim.opt_local.spell = true

-- toggle done with commentstring
vim.bo.commentstring = "x %s"
