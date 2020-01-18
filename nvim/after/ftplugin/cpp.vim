map <buffer> <unique> <localleader>c :call Compile()<Return>

" Compile this c++ file with gcc and print possible errors
function! Compile()
    :!g++ -Wall -Wextra -Wshadow % -o %:r -O2
endfunction
