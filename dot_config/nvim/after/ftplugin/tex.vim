" Dont hard wrap text
setlocal linebreak
setlocal wrap
setlocal textwidth=0

" Use two space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Move within softwrapped lines with j and k
map <buffer> j gj
map <buffer> k gk
