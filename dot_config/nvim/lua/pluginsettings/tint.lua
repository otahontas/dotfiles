local packageName = "levouh/tint.nvim"

local config = function()
  require("tint").setup({
    tint = -90,
    saturation = 0.1,
  })
end

return {
  packageName,
  config = config,
}
