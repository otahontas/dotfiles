" Visual
set number
set showmatch
set laststatus=2
set showcmd
set wildmenu
set wildoptions=tagfile
set t_Co=256
set cursorline
let &colorcolumn="88,".join(range(120,999),",")

" Light theme
" colorscheme one
" set background=light
" let g:one_allow_italics = 1

" Dark theme
colorscheme rigel

if exists('+termguicolors')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Text editing
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=88

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Folding
set nofoldenable

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

" Ignore compiled files, git stuff
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


" Set up correct python3
let g:python3_host_prog = '/usr/bin/python3'

" Set some extra diff-heuristics: https://vimways.org/2018/the-power-of-diff/
set diffopt+=indent-heuristic,algorithm:patience

" Set neovim to use system clipboard
set clipboard=unnamedplus

" Always use current neovim instance as preferred text editor
if has('nvim') && executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
