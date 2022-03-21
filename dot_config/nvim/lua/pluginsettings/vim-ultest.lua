local utils = require("utils")
local map = utils.map

local packageName = "rcarriga/vim-ultest"

local requires = { "vim-test/vim-test" }

local run = ":UpdateRemotePlugins"

-- shortcuts
map("n", "<leader>un", ":UltestNearest")
map("n", "<leader>ul", ":UltestLast")
map("n", "<leader>uo", ":UltestOutput")
map("n", "<leader>us", ":UltestSummary")

local config = function()
  vim.g.ultest_use_pty = 1
end

return {
  packageName,
  requires = requires,
  run = run,
  config = config,
}
