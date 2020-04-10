" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcut
nnoremap <leader>vt <C-w>v<C-w>l:terminal<CR>I
nnoremap <leader>st <C-w>s<C-w>j:terminal<CR>I
tnoremap <ESC> <C-\><C-n>

" Make shortcut
nnoremap <leader>mm :make!<CR>

" Toggle highlighting and hidden chars
nnoremap <leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <leader>sc :set invlist<CR>

" Buffer movement
nnoremap <leader>nb :bnext <CR>
nnoremap <leader>pb :bprev <CR>

" copy and paste with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p

" Fast saving
nnoremap <leader>ww :w!<cr>

" Change window pwd to current dir and print it
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
