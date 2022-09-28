local packageName = "williamboman/mason-lspconfig.nvim"

local after = {
  "mason.nvim",
}

local config = function()
  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
end

return {
  packageName,
  after = after,
  config = config,
}
