local packageName = "hoob3rt/lualine.nvim"

local requires = { "kyazdani42/nvim-web-devicons" }

local config = function()
  local options = { theme = "onelight" }
  local extensions = { "nvim-tree" }
  require("lualine").setup({
    options = options,
    extensions = extensions,
  })
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "5113cdb32f9d9588a2b56de6d1df6e33b06a554a",
}
