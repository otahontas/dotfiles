" Remap leaders
let mapleader = "\<Space>"
let maplocalleader = ","

" Terminal shorcuts, ESC quits :terminal mode
nnoremap <leader>vt :terminal<CR>

" Toggle highlighting and hidden chars
nnoremap <leader>nh :nohlsearch<CR>
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
nnoremap <leader>sc :set invlist<CR>

" Buffer movement
nnoremap <leader>nb :bnext <CR>
nnoremap <leader>pb :bprev <CR>

" Copy and paste with system clipboard. fix new way to do this
"nnoremap <leader>y "+y
"nnoremap <leader>p "+p
