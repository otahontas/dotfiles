local packageName = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

local config = function()
  -- show diagnostics from lsp lines instead of default setup
  vim.diagnostic.config({
    virtual_text = false,
  })

  require("lsp_lines").setup()
end

return {
  packageName,
  config = config,
}
