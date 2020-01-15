" Install Plug if not installed
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
    autocmd source $MYVIMRC
endif

" Load plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/limelight.vim'
Plug 'scrooloose/nerdtree'
Plug 'Rigellute/rigel' 
Plug 'dbeniamine/todo.txt-vim'
Plug 'tpope/vim-commentary'
Plug 'sunaku/vim-dasht'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Source plugin settings
runtime pluginsettings/fzf.vim
runtime pluginsettings/goyo.vim
runtime pluginsettings/lightline.vim
runtime pluginsettings/nerdtree.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vim-dasht.vim
