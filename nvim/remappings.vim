" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcuts, ESC quits :terminal mode
nnoremap <leader>t :terminal<CR>I
nnoremap <leader>vt <C-w>v<C-w>l:terminal<CR>I
nnoremap <leader>st <C-w>s<C-w>j:terminal<CR>I
tnoremap <ESC> <C-\><C-n>

" Toggle highlighting and hidden chars
nnoremap <leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <leader>sc :set invlist<CR>

" Buffer movement and closing
nnoremap <leader>nb :bnext <CR>
nnoremap <leader>pb :bprev <CR>

" Copy and paste with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
