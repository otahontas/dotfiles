vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppucin",
  },
}, {
  load = true,
  confirm = false,
})

require("catppuccin").setup({
  integrations = {
    mini = {
      enabled = true,
      indentscope_color = "mocha",
    },
  },
})
vim.cmd.colorscheme("catppuccin")
