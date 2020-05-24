" If filetype is not c, then don't load these settings
if (&ft != 'c')
    finish
endif

" Compile only this c file with gcc and print possible errors
" For more complex cases, make should be used
nnoremap <buffer><localleader>cc :call Compile()<Return>
function! Compile()
    :!gcc -Wall -Wextra -Wshadow % -o %:r -O2
endfunction
