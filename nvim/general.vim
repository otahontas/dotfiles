" Visual
set number
set showmatch
set termguicolors
colorscheme rigel
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn guibg=#00384D

" Text editing
set expandtab
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4
set textwidth=79

" Search
set ignorecase
set smartcase

" Folding
set foldenable
set foldlevelstart=5
set foldmethod=indent
set foldnestmax=5

" Files and backups
set backup
set backupdir=~/.local/share/nvim/backup//
set fileencoding=utf-8
set undofile
