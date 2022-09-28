local packageName = "stevearc/stickybuf.nvim"

local config = function()
  require("stickybuf").setup()
end

return {
  packageName,
  config = config,
}
