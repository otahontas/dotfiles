" Load configuration files
" Files are dependent, so order is specific
runtime remappings.vim
runtime general.vim

lua <<EOF
-- Load lua-based configurations files
require("plugins")
EOF

" Source some vim plugin settings 
runtime pluginsettings/todotxt-vim.vim
runtime pluginsettings/vim-fugitive.vim
runtime pluginsettings/vimtex.vim
