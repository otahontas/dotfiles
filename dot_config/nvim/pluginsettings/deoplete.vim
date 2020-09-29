" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Close preview automatically after insert
autocmd InsertLeave,CompleteDone * pclose
