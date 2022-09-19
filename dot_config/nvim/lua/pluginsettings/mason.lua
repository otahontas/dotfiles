local packageName = "williamboman/mason.nvim"

local config = function()
  require("mason").setup()
end

return {
  packageName,
  config = config,
}
