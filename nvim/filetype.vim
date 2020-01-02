" My filetype check
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile ~/documents/life/diary/* setfiletype diary
augroup END
