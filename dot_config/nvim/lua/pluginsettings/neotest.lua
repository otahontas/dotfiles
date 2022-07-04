local utils = require("utils")
local map = utils.map

local packageName = "nvim-neotest/neotest"

local requires = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-neotest/neotest-go",
  "haydenmeade/neotest-jest",
  "nvim-neotest/neotest-python",
}

map("n", "<leader>un", '<cmd> lua require("neotest").run.run()')
map("n", "<leader>uo", '<cmd> lua require("neotest").output()')
map("n", "<leader>us", '<cmd> lua require("neotest").summary()')

local config = function()
  require("neotest").setup({
    adapters = {
      require("neotest-go"),
      require("neotest-jest"),
      require("neotest-python"),
    },
  })
end

-- shortcuts

return {
  packageName,
  requires = requires,
  config = config,
  commit = "a291682041908231808b94fff5921babe7a5aa0f",
}
