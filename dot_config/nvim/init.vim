" Load all configuration files
" Files are dependent, so order is specific
runtime remappings.vim
runtime plugins.vim
runtime general.vim

lua <<EOF
-- Load plugin settings written in lua
require("pluginsettings/formatter")
require("pluginsettings/lspkind-nvim")
require("pluginsettings/nvim-compe")
require("pluginsettings/nvim-lspconfig")
require("pluginsettings/nvim-treesitter")
EOF
