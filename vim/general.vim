" Visual
set number
set showmatch
set termguicolors
set laststatus=2
set showcmd
set wildmenu
set wildoptions=tagfile
colorscheme rigel
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn guibg=#00384D

" Text editing
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=79

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Folding
set foldenable
set foldlevelstart=5
set foldmethod=indent
set foldnestmax=5

" Files and backups
set autoread
set backup
set fileencoding=utf-8
set history=1000
set undofile
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
let g:netrw_home=$XDG_CACHE_HOME.'/vim'
