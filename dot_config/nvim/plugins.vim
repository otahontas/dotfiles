" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')
Plug '$XDG_DATA_HOME/nvim/plugged/vim-redact-pass/'
Plug 'Rigellute/rigel'
Plug 'airblade/vim-gitgutter'
Plug 'dbeniamine/todo.txt-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Source plugin settings
runtime pluginsettings/closetag.vim
runtime pluginsettings/coc.vim
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/polyglot.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vimtex.vim
