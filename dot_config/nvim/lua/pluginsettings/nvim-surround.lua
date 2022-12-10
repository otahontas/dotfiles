local packageName = "kylechui/nvim-surround"

local tag = "*"

local config = function()
  require("nvim-surround").setup({})
end

return {
  packageName,
  tag = tag,
  config = config,
}
