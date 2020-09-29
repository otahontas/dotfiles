" Required for operations modifying multiple buffers like rename.
set hidden

" Add more height for commands
set cmdheight=2

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls'],
    \ 'cpp': ['ccls'],
    \ 'javascript': ['tsserver'],
    \ 'javascriptreact': ['tsserver'],
    \ 'rust': ['rust-analyzer'],
    \ 'typescript': ['tsserver'],
    \ 'typescriptreact': ['tsserver'],
    \ 'python': ['pyls'],
    \ }

" Load mappings for buffers where client is supported
function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer><silent>K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <buffer><silent>gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer><silent>gi :call LanguageClient#textDocument_implementation()<CR>
    nnoremap <buffer><silent><leader>rn :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer><silent><leader>dsym :call LanguageClient#textDocument_documentSymbol()<CR>
    nnoremap <buffer><silent><leader>wsym :call LanguageClient#workspace_symbol()<CR>
    nnoremap <buffer><silent><leader>ref :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer><silent><leader>cac :call LanguageClient#textDocument_codeAction()<CR>
    nnoremap <buffer><silent><leader>for :call LanguageClient#textDocument_formatting()<CR>
  endif
endfunction

autocmd FileType * call LC_maps()

" Always load signcolumn when server is started
augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted setlocal signcolumn=yes
  autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END
