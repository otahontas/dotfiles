local packageName = "jose-elias-alvarez/null-ls.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
}

local config = function()
  local null_ls = require("null-ls")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local options = {
    debug = false,
    sources = {
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.cfn_lint,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.gitlint,
      null_ls.builtins.diagnostics.golangci_lint, -- TODO: turn on more useful linters
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.luacheck, -- TODO: setup vim global for .config/nvim folder
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.misspell,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.todo_comments,
      null_ls.builtins.diagnostics.trail_space,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.black, -- TODO: add to mason-null-ls
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
    },
    on_attach = function(client, bufnr)
      -- Set up autoformatting
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.formatting_sync()
          end,
        })
      end
    end,
  }

  null_ls.setup(options)
end

return {
  packageName,
  requires = requires,
  config = config,
}
