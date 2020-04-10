" Quick shortcuts for different fzf-modes
" Double letter is used, since single letters would cause vim to wait (i.e. if
" using b, t and bt as shorcuts)
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :Files $HOME<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>tt :Tags<CR>
nnoremap <leader>bt :BTags<CR>
nnoremap <leader>hh :History<CR>

" Esc exits fzf
autocmd  FileType fzf tnoremap <Esc> <C-c>
    \| autocmd BufLeave <buffer> tnoremap <Esc> <C-\><C-n>
