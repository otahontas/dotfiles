local utils = require("utils")
local map = utils.map

-- Toggle hidden chars
map("n", "<leader>sc", ":set invlist")

-- Open terminal in this, vertical or horisontal split
map("n", "<leader>ss", ":terminal")
map("n", "<leader>vt", "<C-w>v<C-w>l:terminal")
map("n", "<leader>st", "<C-w>s<C-w>j:terminal")

-- Toggle highlighting
map("n", "<leader>nh", ":nohlsearch")

-- Buffer movement
map("n", "<leader>bn", ":bnext")
map("n", "<leader>bp", ":bprev")
map("n", "<leader>bd", ":bdelete")

-- Tabs
map("n", "<leader>tn", ":tabnew")

-- Fast saving
map("n", "<leader>ww", ":w!", { silent = false })

-- Change this windows working directory to current dir and print it
map("n", "<leader>cwd", ":lcd %:p:h<CR>:pwd", { silent = false })

-- Move to normal mode in terminal with Ctrl-W followed by ESC
map("t", "<C-w><Esc>", "<C-\\><C-n>", { suffix = "" })
map("t", "<C-w>k", "<C-\\><C-n><C-w>k", { suffix = "" })
map("t", "<C-w>l", "<C-\\><C-n><C-w>l", { suffix = "" })

-- Move in quickfixlist
map("n", "<leader>cn", ":cnext")
map("n", "<leader>cp", ":cprev")
vim.cmd([[
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <leader>cq :call ToggleQuickFix()<cr>
]])
