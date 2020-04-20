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
if empty(glob('$XDG_DATA_HOME/nvim/backup/'))
    silent !mkdir -p $XDG_DATA_HOME/nvim/backup
endif
set backupdir=~/.local/share/nvim/backup//
let g:netrw_home=$XDG_CACHE_HOME.'/nvim'

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto highlight words, autosave delay, cursorhold trigger, default: 4000ms
setl updatetime=300

highlight WordUnderCursor cterm=underline gui=underline
autocmd CursorHold * call HighlightCursorWord()
function! HighlightCursorWord()
    " if hlsearch is active, don't overwrite it!
    let search = getreg('/')
    let cword = expand('<cword>')
    if match(cword, search) == -1
        exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
    endif
endfunction

" Set some extra diff-heuristics
" https://vimways.org/2018/the-power-of-diff/
set diffopt+=indent-heuristic,algorithm:patience
