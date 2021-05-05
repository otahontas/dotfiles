" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Open terminal in this, vertical or horisontal split
nnoremap <silent><leader>ss :terminal<CR>
nnoremap <silent><leader>vt <C-w>v<C-w>l:terminal<CR>
nnoremap <silent><leader>st <C-w>s<C-w>j:terminal<CR>

" Move to normal mode in terminal with Ctrl-W followed by ESC
tnoremap <silent><C-w><Esc> <C-\><C-n>

" Move between splits normally from terminal mode
tnoremap <silent><C-w>h <C-\><C-n><C-w>h
tnoremap <silent><C-w>j <C-\><C-n><C-w>j
tnoremap <silent><C-w>k <C-\><C-n><C-w>k
tnoremap <silent><C-w>l <C-\><C-n><C-w>l

" Toggle highlighting and hidden chars
nnoremap <silent><leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <silent><leader>sc :set invlist<CR>

" Buffer movement and closing
nnoremap <silent><leader>bn :bnext <CR>
nnoremap <silent><leader>bp :bprev <CR>
nnoremap <silent><leader>bd :bdelete <CR>

" Tabs
nnoremap <silent><leader>tn :tabnew <CR>

" Fast saving
nnoremap <leader>ww :w!<cr>

" Change this windows pwd to current dir and print it
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Reload config
nnoremap <leader>rc :source $MYVIMRC<CR>

" Open config
nnoremap <silent><leader>oc :edit $MYVIMRC<CR>

" Toggle numbers
nnoremap <silent><leader>nt :set invnumber<CR>
