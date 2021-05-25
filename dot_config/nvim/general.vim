" Show linenumber
set number

" Show matching brackets
set showmatch

" Highlight line where cursor is
set cursorline

" Color default line break column + all columns from 120 to right
let &colorcolumn="88,".join(range(120, 999),",")

" Set theme
set termguicolors
set background=light
colorscheme edge

" Set different color for terminal mode cursor
highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=blue guifg=white ctermbg=1 ctermfg=15

" Start on insert mode automatically on terminal
augroup neovim_terminal
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" Try to autoindent when adding a new line
set smartindent

" Always expand tabs to spaces
set expandtab

" Set basic indent to be 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Make hard line break on 88
set textwidth=88

" Ignore case normally, but override ignoring if search contains upper chars
set ignorecase
set smartcase

" Write backup files
set backup

" Set backup dir and create it if necessary
if empty(glob('$XDG_DATA_HOME/nvim/backup/'))
    silent !mkdir -p $XDG_DATA_HOME/nvim/backup
endif
set backupdir=~/.local/share/nvim/backup//

" Always use UTF-8
set fileencoding=utf-8

" Save bookmarks and history to cache
let g:netrw_home=$XDG_CACHE_HOME.'/nvim'

" Ignore following files when completing
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" No annoying sound or visuals on errors
set noerrorbells
set novisualbell

" Don't wait so long for mapped seq to be completed
set timeoutlen=500

" Set lower delay for highlighting words, autosoveing and cursorhold triggers
set updatetime=300

" Return to last edit position when opening files
augroup last_edit_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

" Trigger `autoread` when files changes on disk and notify after file change
set autoread

augroup autoread_trigger
  autocmd!
  autocmd FocusGained, BufEnter, CursorHold, CursorHoldI * if mode() != 'c' | checktime | endif
augroup END

augroup autoread_message
  autocmd!
  autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" Set some extra diff-heuristics: https://vimways.org/2018/the-power-of-diff/
set diffopt+=indent-heuristic,algorithm:patience

" Set neovim to use system clipboard
set clipboard=unnamedplus

" Use current neovim instance as preferred text editor if possible
if executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Run chezmoi --apply after editing files in chezmoi directory
augroup chezmoi_auto_apply
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
augroup END

" Set real filetypes for chezmoi .tmpl files by ignoring .tmpl extension
" A bit clunky, should really take filename and match against different filetypes,
" since this misses files like .zshrc
augroup chezmoi_template_file_setup
  autocmd!
  autocmd BufNewFile,BufRead *.tmpl let &filetype = expand('%:r:e')
augroup END

" Some problems that should be fixed:
" - numbers when opening buffer from terminal buffer (since terminal buffer has them
" hidden)
" - working finnish spellcheck
" - add way to fold stuff in todo-file
" - add way to highlight all tasks due today
" - add way to highlight all tasks to be started today
" - replace fzf with telescope
" - get plugin that shows function/method i'm currently editing
" - replace copypasted after/ftplugin settings with function & function calls
