" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dbeniamine/todo.txt-vim'
Plug 'https://gitlab.com/craftyguy/vim-redact-pass.git'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
Plug 'plasticboy/vim-markdown'
Plug 'sainnhe/edge'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" All-around IDE-like stuff
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
call plug#end()

" Source plugin settings written in lua
lua require("pluginsettings/nvim-compe")
lua require("pluginsettings/nvim-treesitter")
lua require("pluginsettings/nvim-lspconfig")

" Source plugin settings written in vim script
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/lspsaga.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vimtex.vim
