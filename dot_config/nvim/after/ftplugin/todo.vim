" Fold by syntax
setlocal foldmethod=syntax

" Autocompletion (use omnifunc instead of compe)
setlocal omnifunc=todo#Complete
imap <buffer> @ @<C-X><C-O>
imap <buffer> + +<C-X><C-O>
