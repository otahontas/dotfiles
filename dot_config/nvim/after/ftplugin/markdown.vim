setlocal linebreak
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal textwidth=0
setlocal wrap

map <buffer> j gj
map <buffer> k gk

nnoremap <buffer> <localleader>cc :Glow<Return>
nnoremap <buffer> <localleader>wc :call WordCount()<Return>

function! WordCount()
    :! wc %
endfunction
