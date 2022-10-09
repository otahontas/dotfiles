local packageName = "williamboman/mason-lspconfig.nvim"

local requires = {
  "williamboman/mason.nvim",
}

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
  requires = requires,
  after = after,
  config = config,
}
