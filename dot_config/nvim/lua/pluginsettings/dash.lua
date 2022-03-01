local packageName = "mrjones2014/dash.nvim"

local run = "make install"

local config = function()
  local options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("", "<leader>ds", ":Telescope dash search<CR>", options)
  vim.api.nvim_set_keymap("", "<leader>dw", ":DashWord<CR>", options)
end

return {
  packageName,
  run = run,
  config = config,
}
