vim.pack.add({
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = "v1.7.0",
  },
  {
    src = "https://github.com/rafamadriz/friendly-snippets",
  },
}, {
  load = true,
  confirm = false,
})

require("blink.cmp").setup({
  completion = { documentation = { auto_show = true, }, },
  signature = { enabled = true, },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
