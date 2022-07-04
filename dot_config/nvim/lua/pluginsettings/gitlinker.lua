local packageName = "ruifm/gitlinker.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  require("gitlinker").setup()
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "782e98dd1f8f2c97186b13b5c59a472b585a4504",
}
