local packageName = "windwp/nvim-autopairs"

local config = function()
  require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt" },
  })
end

return {
  packageName,
  config = config,
}
