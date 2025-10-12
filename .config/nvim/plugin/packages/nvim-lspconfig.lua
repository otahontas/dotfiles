vim.pack.add({
  {
    src = "https://github.com/neovim/nvim-lspconfig",
  },
}, {
  load = true,
  confirm = false,
})

vim.lsp.enable({ "bashls", "eslint", "lua_ls", "ts_ls", })

vim.lsp.inlay_hint.enable()
-- vim.lsp.inline_completion.enable()
-- vim.keymap.set("i", "<M-l>", function()
--   if not vim.lsp.inline_completion.get() then
--     return "<M-l>"
--   end
-- end, {
--   expr = true,
--   replace_keycodes = true,
--   desc = "Get the current inline completion",
-- })
vim.lsp.on_type_formatting.enable()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      vim.notify("Callback was run on LspAttach but no client was found!")
      return
    end

    -- folding
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- formatting
    if not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("", { clear = false, }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000, })
        end,
      })
    end

    --
  end,
  desc = "Run LSP setup for buffer",
  group = vim.api.nvim_create_augroup("LspSetup", {}),
  pattern = "*",
})
