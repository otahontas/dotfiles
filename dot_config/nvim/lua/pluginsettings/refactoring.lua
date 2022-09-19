local packageName = "ThePrimeagen/refactoring.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
}

local config = function()
  -- TODO: add Printf and Print Var Statements for ez debugging
  require("refactoring").setup({})
end

return {
  packageName,
  requires = requires,
  config = config,
}
