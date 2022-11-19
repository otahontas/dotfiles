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
    debug = true,
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
      null_ls.builtins.formatting.prettier.with({
        disabled_filetypes = { "markdown" },
        condition = function(utils)
          -- check if prettier is configured and/or installed in package.json
          local null_ls_utils = require("null-ls.utils")
          local bufname = vim.api.nvim_buf_get_name(0)
          local root_with_package = null_ls_utils.root_pattern("package.json")(bufname)
          if root_with_package then
            local is_windows = vim.fn.has("win32") == 1
            local path_sep = is_windows and "\\" or "/"
            for line in io.lines(root_with_package .. path_sep .. "package.json") do
              if line:find("prettier") then
                return true
              end
            end
          end

          -- otherwise check for config file
          -- https://prettier.io/docs/en/configuration.html
          local root_files = {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
          }
          return utils.root_has_file(root_files)
        end,
      }),
      null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci" },
      }),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.rome.with({
        condition = function(utils)
          return utils.root_has_file("rome.json")
        end,
      }),
      null_ls.builtins.formatting.trim_newlines.with({
        disabled_filetypes = filetypes_formatted_with_other_formatters,
      }),
      null_ls.builtins.formatting.trim_whitespace.with({
        disabled_filetypes = filetypes_formatted_with_other_formatters,
      }),
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
