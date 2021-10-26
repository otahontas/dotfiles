local map = require("utils").map

-- Shortcuts for different modes
local base = "<cmd>lua require('telescope.builtin')."

-- Neovim internals
map("n", "<leader>bb", base .. "buffers()")
map("n", "<leader>hh", base .. "command_history()")
map("n", "<leader>ma", base .. "keymaps()")
map("n", "<leader>rr", base .. "registers()")

-- Files
map("n", "<leader>ff", base .. "find_files()")
map("n", "<leader>rg", base .. "live_grep()")

-- LSP Pickers
map("n", "gd", base .. "lsp_definitions()")
map("n", "gr", base .. "lsp_references()")
map("n", "ge", base .. "lsp_document_diagnostics()")
map("n", "<leader>ws", base .. "lsp_workspace_symbols()")

require("telescope").setup({
    extensions = {
        dash = {
            file_type_keywords = {
                javascript = {"javascript", "nodejs"},
                typescript = {"typescript", "javascript", "nodejs"},
                typescriptreact = {"typescript", "javascript", "react"},
                javascriptreact = {"javascript", "react"}
            }
        }
    }
})
