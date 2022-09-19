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
}
