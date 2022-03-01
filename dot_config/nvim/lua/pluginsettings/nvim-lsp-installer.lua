local packageName = "williamboman/nvim-lsp-installer"

local requires = {
  "neovim/nvim-lspconfig",
  "RRethy/vim-illuminate",
}

local config = function()
  local lsp_installer = require("nvim-lsp-installer")
  local lspconfig = require("lspconfig")

  local servers = {
    "tsserver",
    "sumneko_lua",
  }

  local base_config = {
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

      if client and client.config and client.config.root_dir then
        vim.api.nvim_set_current_dir(client.config.root_dir)
      end

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      require("illuminate").on_attach(client)
    end,
  }

  local extra_configs = {
    tsserver = {
      root_dir = lspconfig.util.root_pattern("package.json")
        or lspconfig.util.find_git_ancestor(),
    },
    sumneko_lua = {
      root_dir = lspconfig.util.root_pattern("stylua.toml")
        or lspconfig.util.find_git_ancestor(),
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/**/*.lua")] = true,
            },
            maxPreload = 10000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing lsp server: " .. name)
      server:install()
    end
  end

  local setup_server = function(server)
    local opts = server:get_default_options()
    local nvim_cmp_settings = {
      capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      ),
    }
    opts = vim.tbl_deep_extend("force", opts, nvim_cmp_settings)
    opts = vim.tbl_deep_extend("force", opts, base_config)
    opts = vim.tbl_deep_extend("force", opts, extra_configs[server.name])
    server:setup(opts)
  end

  lsp_installer.on_server_ready(setup_server)
end

return { packageName, requires = requires, config = config }
