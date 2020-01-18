setlocal linebreak
setlocal wrap
setlocal textwidth=0
map <buffer> <unique> j gj
map <buffer> <unique> k gk
map <buffer> <unique> <localleader>c :call Compile()<Return>
map <buffer> <unique> <localleader>w :call WordCount()<Return>

" Compile markdown into HTML with marked.js library and open it in firefox
function! Compile()
    :!file=$(mktemp); marked % > file && firefox-developer-edition file
endfunction

function! WordCount()
    echom "Newlines, word, and bytes:"
    :! wc %
endfunction
