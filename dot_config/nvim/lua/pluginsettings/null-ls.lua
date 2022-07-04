local packageName = "jose-elias-alvarez/null-ls.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
}

local config = function()
  local null_ls = require("null-ls")

  local eslint_files = {
    ".eslintrc*",
    "package.json",
  }

  local eslint_condition = function(utils)
    return utils.has_file(eslint_files) or utils.root_has_file(eslint_files)
  end

  local eslint_cwd = function(params)
    local utils = require("null-ls.utils")
    return utils.root_pattern(eslint_files)(params.bufname)
  end

  local prettier_files = {
    ".prettierrc*",
    "package.json",
  }

  local prettier_condition = function(utils)
    return utils.has_file(prettier_files) or utils.root_has_file(prettier_files)
  end

  local prettier_cwd = function(params)
    local utils = require("null-ls.utils")
    return utils.root_pattern(prettier_files)(params.bufname)
  end

  local options = {
    debug = false,
    sources = {
      null_ls.builtins.code_actions.eslint_d.with({
        cwd = eslint_cwd,
        condition = eslint_condition,
      }),
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.eslint_d.with({
        cwd = eslint_cwd,
        condition = eslint_condition,
      }),
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.shellcheck.with({
        diagnostics_format = "#{m} [#{s}] [#{c}]",
      }),
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.eslint_d.with({
        cwd = eslint_cwd,
        condition = eslint_condition,
      }),
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.formatting.prettierd.with({
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/prettierrc.json"),
        },
        cwd = prettier_cwd,
        condition = prettier_condition,
      }),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.trim_whitespace,
    },
    on_attach = function(client)
      vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true
    end,
  }

  null_ls.setup(options)
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "a2b7bf89663c78d58a5494efbb791819a24bb025",
}
