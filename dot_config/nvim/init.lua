if vim.fn.has("nvim-0.7") == 0 then
  error("Neovim v0.7+ is needed in order to run!")
end

require("core")
require("integrations")
require("plugins")

-- TODO:
-- old plugins.lua -> new plugins
-- formatter --> ls_null
-- tslint, eslint, prettier local config kuntoon 
-- faster telescope
-- faster resolving for lsp
