-- Set up keybindings
local map = require("utils").map
map("n", "<leader>ee", ":NvimTreeToggle")
map("n", "<leader>er", ":NvimTreeRefresh")
map("n", "<leader>en", ":NvimTreeFindFile")

-- Open tree automatically when opening vim with empty file
vim.g.nvim_tree_auto_open = 1

-- Close tree when it's the last window
vim.g.nvim_tree_auto_close = 1

-- Open tree when opening new tab
vim.g.nvim_tree_tab_open = 1

-- Highlight openend files
vim.g.nvim_tree_highlight_opened_files = 1

-- Update cursor to correct position in the tree when entering tree buffer
vim.g.nvim_tree_follow = 1
