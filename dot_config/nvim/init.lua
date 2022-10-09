if vim.fn.has("nvim-0.8") == 0 then
  error("Neovim v0.8+ is needed in order to run!")
end

require("core")
require("integrations")
require("plugins")
