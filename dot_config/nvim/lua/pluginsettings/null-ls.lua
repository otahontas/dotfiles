local packageName = "jose-elias-alvarez/null-ls.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
}

local after = {
  "mason.nvim",
}

local config = function()
  local null_ls = require("null-ls")

  local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end

  local filetypes_formatted_with_other_formatters = {
    "css",
    "go",
    "graphql",
    "handlebars",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "less",
    "lua",
    "markdown",
    "markdown.mdx",
    "python",
    "scss",
    "sh",
    "typescript",
    "typescriptreact",
    "vue",
    "yaml",
  }

  local options = {
    debug = false,
    sources = {
      null_ls.builtins.code_actions.cspell,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.cfn_lint,
      null_ls.builtins.diagnostics.cspell,
      null_ls.builtins.diagnostics.gitlint,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.formatting.prettierd.with({
        disabled_filetypes = { "markdown" },
        condition = function(utils)
          local hasPackageJson = utils.root_has_file("package.json")
          if hasPackageJson then
            -- if in actual js project, run only if prettier config is there
            return utils.root_has_file(".prettierrc", ".prettierrc.json")
          end

          -- otherwise run always so single files are formatted
          return true
        end,
      }),
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.trim_newlines.with({
        disabled_filetypes = filetypes_formatted_with_other_formatters,
      }),
      null_ls.builtins.formatting.trim_whitespace.with({
        disabled_filetypes = filetypes_formatted_with_other_formatters,
      }),
      null_ls.builtins.formatting.rome,
    },
    on_attach = on_attach,
  }

  null_ls.setup(options)
end

return {
  packageName,
  requires = requires,
  after = after,
  config = config,
}
