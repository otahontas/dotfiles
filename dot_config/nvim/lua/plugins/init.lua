local packer = require("plugins.packer")
packer.install()

local loadPlugins = function(use)
  use(packer.packer)
  use(require("plugins.copilot"))
  use(require("plugins.edge"))
  use(require("plugins.indent-blankline"))
  use(require("plugins.kommentary"))
  use(require("plugins.nvim-colorizer"))
  use(require("plugins.nvim-lsp-installer"))
  use(require("plugins.nvim-scrollview"))
  use(require("plugins.nvim-tree"))
  use(require("plugins.suda"))
  use(require("plugins.vim-redact-pass"))
end

-- WISHLIST (e.g. learn to use and incorporate to daily workflow):
-- dash.nvim
-- https://github.com/lewis6991/impatient.nvim 
-- magit
-- joku plugari filun rakenteen tarkastelemiseen & missä vaiheessa meen (jotta välttää
-- sen, että "missäs tän funkkarin alku on"
-- neogen
-- https://github.com/karb94/neoscroll.nvim

return packer.getStartup()(loadPlugins)
