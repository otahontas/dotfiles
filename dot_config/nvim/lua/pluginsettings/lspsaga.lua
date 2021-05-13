--- setup different keys for action quits
local custom_keys = {
    code_action_keys = {quit = "<ESC>"},
    rename_action_keys = {quit = "<ESC>"}
}

-- Setup saga
local saga = require("lspsaga")
saga.init_lsp_saga(custom_keys)

-- Setup keymappings
local map = require("utils").map

-- Rename popup
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()")

-- Setup hover docs
map("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()")

-- Code actions list
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()")
map("v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()")

-- Signature help
map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()")

-- Diagnostics
map("n", "gl", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()")
map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()")
map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()")

-- Peak definition (like gd, but in popup)
map("n", "<leader>gd", "<cmd>lua require'lspsaga.provider'.preview_definition()")

-- Scroll hovers line by line
map("n", "<C-p>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)")
map("n", "<C-n>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)")
