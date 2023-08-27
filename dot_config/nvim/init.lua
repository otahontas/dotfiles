-- Setup impatient cache if it's available
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
else
  print("Impatient not installed!")
end

-- Error when running wrong version
if vim.fn.has("nvim-0.9") == 0 then
  error("Neovim v0.9+ is needed in order to run!")
end

-- disable netrw very early (strongly advised in nvim-tree docs)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Require modules
require("core")
require("plugins")
