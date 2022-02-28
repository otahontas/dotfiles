local packageName = "jose-elias-alvarez/null-ls.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local null_ls = require("null-ls")
  local options = {
    sources = {
      null_ls.builtins.formatting.stylua,
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
      end
    end,
  }
  null_ls.setup(options)
end

return { packageName, requires = requires, config = config }
