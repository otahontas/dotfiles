local packageName = "jayp0521/mason-null-ls.nvim"

local requires = {
  "jose-elias-alvarez/null-ls.nvim",
}

local after = {
  "null-ls.nvim",
}

local config = function()
  require("mason-null-ls").setup({
    automatic_installation = true,
  })
end

return {
  packageName,
  requires = requires,
  after = after,
  config = config,
}
