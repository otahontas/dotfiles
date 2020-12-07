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

" Visual elements
Plug 'Rigellute/rigel'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'rakr/vim-one'

" Language stuff and text helpers
Plug 'dbeniamine/todo.txt-vim'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'

" Security and system
Plug '$XDG_DATA_HOME/nvim/plugged/vim-redact-pass/'
Plug 'lambdalisue/suda.vim'

" All-around features
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
call plug#end()

" Source other plugin settings
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vimtex.vim
