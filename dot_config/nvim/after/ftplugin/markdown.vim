" Dont hard wrap text
setlocal linebreak
setlocal textwidth=0
setlocal wrap

" Use two space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Move within softwrapped lines with j and k
map <buffer> j gj
map <buffer> k gk

" Print word count to statusline
function! WordCount()
    :! wc %
endfunction
nnoremap <buffer> <localleader>wc :call WordCount()<CR>
