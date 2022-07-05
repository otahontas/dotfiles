" Compile only this c++ file with gcc and print possible errors
" For more complex cases, make should be used
nnoremap <buffer><leader>ll :call Compile()<Return>
function! Compile()
    :!g++ -std=c++17 -Wall -Wextra -Wshadow % -o %:r -O2
endfunction
