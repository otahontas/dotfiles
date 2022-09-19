local packageName = "jayp0521/mason-null-ls.nvim"

local after = {
  "null-ls.nvim",
  "mason.nvim",
}

local config = function()
  require("mason-null-ls").setup({
    automatic_installation = true,
  })
  require("mason-null-ls").check_install(true)
end

return {
  packageName,
  after = after,
  config = config,
}
