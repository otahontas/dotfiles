if vim.o.filetype ~= "c" then
  return
end

local compileCommand = "gcc -Wall -Wextra -Wshadow % -o %:r -O2"
vim.keymap.set("n", "<leader>ll", "<cmd>! " .. compileCommand .. "<cr>")
