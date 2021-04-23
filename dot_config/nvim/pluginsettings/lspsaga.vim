" Setup Lsp saga keybindings
lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

" Hovers scrolling (works on signature, docs, code actions etc)
nnoremap <silent><C-i> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

" Docs
nnoremap <silent>K :Lspsaga hover_doc<CR>

" Code actions list
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" Signature help
nnoremap <silent>gs :Lspsaga signature_help<CR>

" Rename
nnoremap <silent><leader>rn :Lspsaga rename<CR>

" Diagnostics
nnoremap <silent><leader>ge :Lspsaga show_line_diagnostics<CR>
nnoremap <silent>[d :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>]d :Lspsaga diagnostic_jump_next<CR>

" Peak definition (like gd, but in popup)
nnoremap <silent><leader>gd :Lspsaga preview_definition<CR>
