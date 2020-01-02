" Load this folder, home folder or buffers quickly
nnoremap <leader>f :Files<CR>
nnoremap <leader>hf :Files $HOME<CR>
nnoremap <leader>b :Buffers <CR>

" Esc exits fzf
autocmd  FileType fzf tnoremap <Esc> <C-c>
    \| autocmd BufLeave <buffer> tnoremap <Esc> <C-\><C-n>
