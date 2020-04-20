" Compile only this c++ file with gcc and print possible errors
" For more complex cases, make should be used
nnoremap <buffer><localleader>cc :call Compile()<Return>
function! Compile()
    :!g++ -Wall -Wextra -Wshadow % -o %:r -O2
endfunction
