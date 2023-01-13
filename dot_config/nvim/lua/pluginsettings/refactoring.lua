local packageName = "ThePrimeagen/refactoring.nvim"

local config = function()
  require("refactoring").setup({})
end

return {
  packageName,
  config = config,
}
