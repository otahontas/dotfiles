local map = require("utils").map
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("n", "<leader>ss", ":terminal")
map("n", "<leader>vt", "<C-w>v<C-w>l:terminal")
map("n", "<leader>st", "<C-w>s<C-w>j:terminal")
map("n", "<leader>nh", ":nohlsearch")
map("n", "<leader>sc", ":set invlist")
map("n", "<leader>bn", ":bnext")
map("n", "<leader>bp", ":bprev")
map("n", "<leader>bd", ":bdelete")
map("n", "<leader>tn", ":tabnew")
map("t", "<C-w><Esc>", "<C-\\><C-n>", { noCR = true})
map("t", "<C-w>h", "<C-\\><C-n><C-w>h", { noCR = true})
map("t", "<C-w>j", "<C-\\><C-n><C-w>j", { noCR = true})
map("t", "<C-w>k", "<C-\\><C-n><C-w>k", { noCR = true})
map("t", "<C-w>l", "<C-\\><C-n><C-w>l", { noCR = true})
map("n", "<leader>ww", ":w!", { silent = false})
map("n", "<leader>cwd", ":lcd %:p:h<CR>:pwd", { silent = false})
