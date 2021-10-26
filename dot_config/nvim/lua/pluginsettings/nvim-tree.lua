-- Set up keybindings
local map = require("utils").map
map("n", "<leader>ee", ":NvimTreeToggle")
map("n", "<leader>er", ":NvimTreeRefresh")
map("n", "<leader>en", ":NvimTreeFindFile")

-- Highlight openend files
vim.g.nvim_tree_highlight_opened_files = 1

-- Other settings
local settings = {
    auto_close = true,
    open_on_tab = true,
    update_focused_file = {enable = true},
    view = {auto_resize = true}
}
require"nvim-tree".setup(settings)
