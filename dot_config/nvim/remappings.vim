" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcut
nnoremap <silent><leader>vt <C-w>v<C-w>l:terminal<CR>I
nnoremap <silent><leader>st <C-w>s<C-w>j:terminal<CR>I

" Toggle highlighting and hidden chars
nnoremap <silent><leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <silent><leader>sc :set invlist<CR>

" Buffer movement and closing
nnoremap <silent><leader>bn :bnext <CR>
nnoremap <silent><leader>bp :bprev <CR>
nnoremap <silent><leader>bd :bdelete <CR>

" Fast saving
nnoremap <leader>ww :w!<cr>

" Change window pwd to current dir and print it
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
