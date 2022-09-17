local map = require("utils").map
-- quick compile for small scripts
local compileCommand = "g++ -std=c++17 -Wall -Wextra -Wshadow % -o %:r -O2"
map("n", "<leader>ll", "<cmd>! " .. compileCommand, { silent = false })
