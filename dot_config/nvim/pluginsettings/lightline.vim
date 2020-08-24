" Set lightline colours
let g:rigel_ligtline=1

let g:lightline = { 
    \ 'colorscheme' : 'rigel', 
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name',
    \ },
    \ }
