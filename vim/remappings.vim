" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcut
nnoremap <leader>te :term<CR>

" Make shortcut
nnoremap <leader>mm :make!<CR>

" Toggle highlighting and hidden chars
nnoremap <leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <leader>sc :set invlist<CR>

" Buffer movement
nnoremap <leader>nb :bnext <CR>
nnoremap <leader>pb :bprev <CR>

" Write selected text to system clipboard
noremap <leader>yy :write !wl-copy<CR><CR>

" Paste text below from system clipboard
nnoremap <leader>pp :read !wl-paste<CR>

" Fast saving
nnoremap <leader>ww :w!<cr>
