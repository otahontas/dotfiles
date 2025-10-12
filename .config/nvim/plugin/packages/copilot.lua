vim.pack.add({
  {
    src = "https://github.com/zbirenbaum/copilot.lua",
  },
  {
    src = "https://github.com/copilotlsp-nvim/copilot-lsp",
  },
}, {
  load = true,
  confirm = false,
})

require("copilot").setup({
  panel = {
    enabled = false,
  },
  -- TODO: check
  -- nes = {
  --   enabled = true,
  -- },
})
