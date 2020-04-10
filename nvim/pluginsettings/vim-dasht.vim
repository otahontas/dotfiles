" search related docsets
nnoremap <Leader>dsr :Dasht<Space>

" search ALL the docsets
nnoremap <Leader>dsa :Dasht!<Space>

" search related docsets for word under cursor
nnoremap <silent> <Leader>dcr :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>

" search ALL the docsets for word under cursor
nnoremap <silent> <Leader>dca :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>

" Setup related docsets:
let g:dasht_filetype_docsets = {}
" When in C++, search for c++
let g:dasht_filetype_docsets['cpp'] = ['c++']
" When in Javascript, also search for React
let g:dasht_filetype_docsets['js'] = ['js', 'react']
