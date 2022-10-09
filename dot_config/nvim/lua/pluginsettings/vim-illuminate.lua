local packageName = "RRethy/vim-illuminate"

local config = function()
  require("illuminate")
end

return {
  packageName,
  config = config,
}
