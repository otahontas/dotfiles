local packageName = "hoob3rt/lualine.nvim"

local requires = { "kyazdani42/nvim-web-devicons" }

local config = function()
  require("lualine").setup({
    options = {
      theme = "github_light_default",
    },
    extensions = {
      "nvim-tree",
    },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "5113cdb32f9d9588a2b56de6d1df6e33b06a554a",
}
