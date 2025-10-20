local utils = require("utils")
utils.disable_hard_wrap_for_buffer(0)

-- toggle done with commentstring
vim.bo.commentstring = "x %s" 
