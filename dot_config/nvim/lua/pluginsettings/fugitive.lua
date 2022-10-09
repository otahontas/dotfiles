local packageName = "tpope/vim-fugitive"

local config = function()
  vim.keymap.set("n", "<leader>G", ":G ", {})
end

return {
  packageName,
  config = config,
}
