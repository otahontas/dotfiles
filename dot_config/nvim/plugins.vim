" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

" VIMSCRIPT BASED

" Safety
Plug 'https://gitlab.com/craftyguy/vim-redact-pass.git'
Plug 'lambdalisue/suda.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Text editing
Plug 'dbeniamine/todo.txt-vim'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-commentary'

" Visual
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'sainnhe/edge'

" All-around IDE-like stuff (older)
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'

" Helping tools
Plug 'airblade/vim-rooter'

" LUA BASED

" Visual
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}

" Text editing
Plug 'mhartington/formatter.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-compe'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'

" Language server stuff, treesitter and helpers
Plug 'glepnir/lspsaga.nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" Source plugin settings written in vim script
runtime pluginsettings/fzf.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/lspsaga.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vim-rooter.vim
runtime pluginsettings/vimtex.vim
