local packageName = "jose-elias-alvarez/null-ls.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
}

local config = function()
  local null_ls = require("null-ls")
  local options = {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd.with({
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/prettierrc.json"),
        },
      }),
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck.with({
        diagnostics_format = "#{m} [#{s}] [#{c}]",
      }),
    },
    update_on_insert = true,
    on_attach = function(client, bufnr)
      local mode = "n"
      local opts = { noremap = true, silent = true }
      local mappings = {
        { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
        {
          "gi",
          "<cmd>lua vim.lsp.buf.implementation()<CR>",
        },
        {
          "gs",
          "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        },
        {

          "<leader>wa",
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        },
        {

          "<leader>wr",
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        },
        {
          "<leader>wl",
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        },
        {
          "<leader>D",
          "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        },
        { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
        { "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>" },
        { "<leader>ge", "<cmd>lua vim.diagnostic.setloclist()<CR>" },
        { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
        { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
      }

      for _, value in pairs(mappings) do
        local key, command = unpack(value)
        vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
      end

      -- set up autoformatting
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])

      -- set up root dir
      if client and client.config and client.config.root_dir then
        vim.api.nvim_set_current_dir(client.config.root_dir)
      end

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true

      require("illuminate").on_attach(client)
    end,
  }

  null_ls.setup(options)
end

return { packageName, requires = requires, config = config }
