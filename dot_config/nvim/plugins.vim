" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Source settings for needed plugins before plugins themselves are loaded
runtime pluginsettings/polyglot.vim

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dbeniamine/todo.txt-vim'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'https://gitlab.com/craftyguy/vim-redact-pass.git'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'plasticboy/vim-markdown'
Plug 'sainnhe/edge'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
call plug#end()

" Source spesific plugin settings
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/lspsaga.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/nvim-compe.vim
runtime pluginsettings/nvim-lspconfig.vim
runtime pluginsettings/nvim-lspinstall.vim
runtime pluginsettings/nvim-treesitter.vim
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vimtex.vim
