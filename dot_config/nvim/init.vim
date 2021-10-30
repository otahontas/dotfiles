" Load configuration files
" Files are dependent, so order is specific
runtime remappings.vim
runtime general.vim

lua <<EOF
-- Load lua-based configurations files
require("plugins")
EOF
