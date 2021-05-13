-- Set up keybindings
local map = require("utils").map

map("n", "<leader>ee", ":NvimTreeToggle")
map("n", "<leader>er", ":NvimTreeRefresh")
map("n", "<leader>en", ":NvimTreeFindFile")
