vim.g.mapleader = " "
local set = vim.keymap.set
set(
  "n",
  "<leader>sc",
  "<cmd>set invlist<cr>",
  { silent = true, desc = "Toggle hidden chars", }
)
set(
  "n",
  "<leader>ss",
  "<cmd>terminal<cr>",
  { silent = true, desc = "Open terminal in current window", }
)
set(
  "n",
  "<leader>vt",
  "<C-w>v<C-w>l<cmd>terminal<cr>",
  { silent = true, desc = "Open terminal in vertical split", }
)
set(
  "n",
  "<leader>st",
  "<C-w>s<C-w>j<cmd>terminal<cr>",
  { silent = true, desc = "Open terminal in horizontal split", }
)
set(
  "n",
  "<leader>nh",
  "<cmd>nohlsearch<cr>",
  { silent = true, desc = "Turn off highlighted search results", }
)
set("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true, desc = "Open new tab", })
set("n", "<leader>ww", "<cmd>w!<cr>", { silent = false, desc = "Save file", })
set(
  "t",
  "<C-w><Esc>",
  "<C-\\><C-n>",
  { silent = true, desc = "Go to normal mode with Ctrl-W Esc in terminal mode", }
)
