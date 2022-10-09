local packageName = "stevearc/dressing.nvim"

local config = function()
  require("dressing").setup()
end

return {
  packageName,
  config = config,
}
