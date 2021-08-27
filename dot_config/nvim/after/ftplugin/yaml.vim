" Use two space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Autoremove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
