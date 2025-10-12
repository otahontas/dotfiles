vim.pack.add({
  {
    src = "https://github.com/m4xshen/hardtime.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("hardtime").setup()
