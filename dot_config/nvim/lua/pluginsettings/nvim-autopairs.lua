local packageName = "windwp/nvim-autopairs"

local config = function()
  require("nvim-autopairs").setup()
end

return {
  packageName,
  config = config,
  commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf",
}
