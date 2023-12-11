-- Toggle hidden chars
vim.keymap.set("n", "<leader>sc", "<cmd>set invlist<cr>", { silent = true })

-- Open terminal in this, vertical or horisontal split
vim.keymap.set("n", "<leader>ss", "<cmd>terminal<cr>", { silent = true })
vim.keymap.set("n", "<leader>vt", "<C-w>v<C-w>l<cmd>terminal<cr>", { silent = true })
vim.keymap.set("n", "<leader>st", "<C-w>s<C-w>j<cmd>terminal<cr>", { silent = true })

-- Toggle highlighting
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { silent = true })

-- Buffer movement
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", { silent = true })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { silent = true })

-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true })

-- Fast saving
vim.keymap.set("n", "<leader>ww", "<cmd>w!<cr>", { silent = false })

-- Change this windows working directory to current dir and print it
vim.keymap.set("n", "<leader>cwd", "<cmd>lcd %:p:h<cr>:pwd<cr>", { silent = false })

-- Move to normal mode in terminal with Ctrl-W followed by ESC
vim.keymap.set("t", "<C-w><Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { silent = true })

-- Move in quickfixlist
vim.keymap.set("n", "<leader>cn", "<cmd>:cnext<cr>", { silent = true })
vim.keymap.set("n", "<leader>cp", "<cmd>:cprev<cr>", { silent = true })
vim.cmd([[
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
]])
vim.keymap.set("n", "<leader>cq", "<cmd>call ToggleQuickFix()<cr>", { silent = true })

-- Move in locationlist
vim.keymap.set("n", "<leader>ln", "<cmd>:lnext<cr>", { silent = true })
vim.keymap.set("n", "<leader>lp", "<cmd>:lprev<cr>", { silent = true })
vim.cmd([[
function! ToggleLocList()
    if empty(filter(getwininfo(), 'v:val.loclist'))
        lopen
    else
        lclose
    endif
endfunction
]])
vim.keymap.set("n", "<leader>lq", "<cmd>call ToggleLocList()<cr>", { silent = true })

-- Netrw
vim.keymap.set("n", "<leader>ee", ":Explore<cr>", { silent = true })
vim.keymap.set("n", "<leader>ee", ":Explore %:p:h<cr>", { silent = true })
vim.keymap.set("n", "<leader>se", ":Sexplore<cr>", { silent = true })
vim.keymap.set("n", "<leader>ve", ":Vexplore<cr>", { silent = true })

-- show file tree list
vim.keymap.set("n", "<leader>tr", ":! tree<cr>", { silent = true })
