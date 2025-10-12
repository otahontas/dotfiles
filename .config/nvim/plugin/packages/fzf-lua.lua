local utils = require("utils")
local set = vim.keymap.set

vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
  },
  {
    load = true,
    confirm = false,
  }
)

local fzf = require("fzf-lua")

fzf.setup({
  defaults = { git_icons = "true", file_icons = "mini", },
})
set("n", "<leader>fzf", "<cmd>FzfLua<cr>", { desc = "Open FZF", })
-- files
set("n", "<leader>fdd", "<cmd>FzfLua files<cr>", { desc = "Find files", })
set("n", "<leader>fdc", function()
  fzf.files({ cwd = utils.get_current_directory(), })
end, { desc = "Find files in current file's directory", })
set("n", "<leader>fdp", function()
  fzf.files({
    cwd = utils.get_closest_ancestor_directory_that_has_file(
      "package.json"),
  })
end, { desc = "Find files in package.json directory", })
-- grep
set("n", "<leader>rgg", "<cmd>FzfLua grep<cr>", { desc = "Grep files", })
set("n", "<leader>rgc", function()
  fzf.grep({ cwd = utils.get_current_directory(), })
end, { desc = "Grep in current file's directory", })
set("n", "<leader>rgp", function()
  fzf.grep({
    cwd = utils.get_closest_ancestor_directory_that_has_file(
      "package.json"),
  })
end, { desc = "Grep in package.json directory", })
