local utils = require("utils")
local map = utils.map

local packageName = "nvim-neotest/neotest"

local requires = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-neotest/neotest-go",
  "haydenmeade/neotest-jest",
}

-- mappings ()
map("n", "<leader>us", '<cmd> lua require("neotest").summary.toggle()')
map("n", "<leader>un", '<cmd> lua require("neotest").run.run()')
map("n", "<leader>uf", '<cmd> lua require("neotest").run.run(vim.fn.expand("%"))')
map("n", "<leader>uo", '<cmd> lua require("neotest").output.open()')

-- create commands (follow ultest api)
vim.cmd([[
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! NeotestNearest lua require("neotest").run.run()
command! NeotestOutput lua require("neotest").output.open()
]])

local config = function()
  require("neotest").setup({
    adapters = {
      require("neotest-jest")({
        jestCommand = "npm test --", --TODO: Fix, not working
      }),
      require("neotest-go")({
        experimental = {
          test_table = true,
        },
      }),
    },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
}
