-- Setup treesitter
require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    -- Highlighting fails on multi-part tex documents, otherwise enable
    highlight = {enable = true, disable = {"latex"}},
    indent = {enable = true},
    rainbow = {enable = true}
}

-- Use treesitter to handle folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Start always with all folds open
vim.o.foldlevelstart = 20
