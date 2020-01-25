" Add autocompletions
setlocal omnifunc=todo#Complete
au filetype todo imap <buffer> <unique> + +<C-X><C-O>
au filetype todo imap <buffer> <unique> @ @<C-X><C-O>

" Autoadd prefixes
let g:Todo_txt_prefix_creation_date=1
