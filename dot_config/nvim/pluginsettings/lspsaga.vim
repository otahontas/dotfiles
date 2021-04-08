" Setup Lsp saga keybindings
nnoremap <silent>ca :Lspsaga code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-p> :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent><C-n> :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent><C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>
