local compileCommand = "g++ -std=c++17 -Wall -Wextra -Wshadow % -o %:r -O2"
vim.keymap.set("n", "<leader>ll", "<cmd>! " .. compileCommand .. "<CR>")
