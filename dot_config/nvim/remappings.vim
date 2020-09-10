" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcut
nnoremap <leader>te :terminal<CR>I
nnoremap <leader>vt <C-w>v<C-w>l:terminal<CR>I
nnoremap <leader>st <C-w>s<C-w>j:terminal<CR>I

" Toggle highlighting and hidden chars
nnoremap <leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <leader>sc :set invlist<CR>

" Buffer movement and closing
nnoremap <leader>bn :bnext <CR>
nnoremap <leader>bp :bprev <CR>
nnoremap <leader>bd :bdelete <CR>

" Fast saving
nnoremap <leader>ww :w!<cr>

" Change window pwd to current dir and print it
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
