setlocal linebreak
setlocal wrap
setlocal textwidth=0
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
map <buffer> <unique> j gj
map <buffer> <unique> k gk
nnoremap <buffer> <unique> <localleader>cc :call Compile()<Return>
nnoremap <buffer> <unique> <localleader>wc :call WordCount()<Return>

" Compile markdown into HTML with marked.js library and open it in firefox
function! Compile()
    :!file=$(mktemp); marked % > $file && firefox-developer-edition $file
endfunction

function! WordCount()
    :! wc %
endfunction
