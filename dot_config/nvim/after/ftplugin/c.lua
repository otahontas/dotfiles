local map = require("utils").map
if vim.o.filetype ~= "c" then
  return
end

-- quick compile for small scripts
local compileCommand = "gcc -Wall -Wextra -Wshadow % -o %:r -O2"
map("n", "<leader>ll", "<cmd>! " .. compileCommand, { silent = false })
