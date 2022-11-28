local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- print("formatting with client" .. client.name)
      -- TODO: resolve best client, then cache by buffer
      -- if client.name == "null-ls" then
      -- print(vim.inspect(client))
      -- end
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

local setup_format_on_save = function(client, bufnr)
  if not client.supports_method("textDocument/formatting") then
    return
  end
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      lsp_formatting(bufnr)
    end,
  })
end

return {
  setup_format_on_save = setup_format_on_save,
}
