local packageName = "levouh/tint.nvim"

local config = function()
  require("tint").setup({})
end

return {
  packageName,
  config = config,
}
