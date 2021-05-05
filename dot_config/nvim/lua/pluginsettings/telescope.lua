local map = require("utils").map

-- Shortcuts for different modes
local base = "<cmd>lua require('telescope.builtin')."

-- Neovim internals
map("n", "<leader>bb", base .. "buffers()")
map("n", "<leader>hh", base .. "command_history()")
map("n", "<leader>ma", base .. "keymaps()")

-- Files
map("n", "<leader>ff", base .. "find_files()")
map("n", "<leader>rg", base .. "live_grep()")

-- LSP Pickers
map("n", "<leader>gd", base .. "lsp_definitions()")
map("n", "<leader>gr", base .. "lsp_references()")
map("n", "<leader>ge", base .. "lsp_document_diagnostics()")
