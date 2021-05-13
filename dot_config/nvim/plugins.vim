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

" Visual
Plug 'sainnhe/edge'

call plug#end()

" Source settings 
runtime pluginsettings/suda.vim
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vim-fugitive.vim
runtime pluginsettings/vimtex.vim
