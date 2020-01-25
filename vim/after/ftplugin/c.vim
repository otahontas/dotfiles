" Set completions
setlocal omnifunc=syntaxcomplete#Complete

" Compile only this c file with gcc and print possible errors
" For more complex cases, make should be used
map <buffer> <unique> <localleader>c :call Compile()<Return>
function! Compile()
    :!gcc -Wall -Wextra -Wshadow % -o %:r -O2
endfunction
