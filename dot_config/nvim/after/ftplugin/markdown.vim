setlocal linebreak
setlocal wrap
setlocal textwidth=0
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
map <buffer> j gj
map <buffer> k gk
nnoremap <buffer> <localleader>cc :call Compile()<Return>
nnoremap <buffer> <localleader>wc :call WordCount()<Return>

" Compile markdown into HTML with marked.js library and open it in firefox
function! Compile()
    :!file=$(mktemp); marked % > $file && $BROWSER $file
endfunction

function! WordCount()
    :! wc %
endfunction
