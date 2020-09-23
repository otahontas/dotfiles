" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Polyglot must be sourced before polyglot is loaded
runtime pluginsettings/polyglot.vim

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

" Visual elements
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'rakr/vim-one'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'

" Language stuff and text helpers
Plug 'alvan/vim-closetag'
Plug 'dbeniamine/todo.txt-vim'
Plug 'edgedb/edgedb-vim'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Security and system
Plug '$XDG_DATA_HOME/nvim/plugged/vim-redact-pass/'
Plug 'lambdalisue/suda.vim'

" All-around features (git, search, intellisense, linting, testing) 
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Source other plugin settings
runtime pluginsettings/closetag.vim
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vim-test.vim
runtime pluginsettings/vimtex.vim
