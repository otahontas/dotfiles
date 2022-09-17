local packageName = "williamboman/nvim-lsp-installer"

local requires = {
  "neovim/nvim-lspconfig",
  "RRethy/vim-illuminate",
  "b0o/SchemaStore.nvim",
  "stevearc/dressing.nvim",
}

local config = function()
  local lsp_installer = require("nvim-lsp-installer")
  local lspconfig = require("lspconfig")

  local servers = {
    "cssls",
    "dockerls",
    "gopls",
    "graphql",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sourcery",
    "taplo",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "yamlls",
  }

  local create_capabilities_for_langservers_extracted_from_vscode = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
  end

  local server_spesific_opts = {
    cssls = {
      capabilities = create_capabilities_for_langservers_extracted_from_vscode(),
    },
    html = {
      capabilities = create_capabilities_for_langservers_extracted_from_vscode(),
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true
      end,
    },
    jsonls = {
      capabilities = create_capabilities_for_langservers_extracted_from_vscode(),
      override_opts = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      },
    },
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
              "cargo",
              "clippy",
              "--workspace",
              "--message-format=json",
              "--all-targets",
              "--all-features",
            },
          },
        },
      },
    },
    sumneko_lua = {
      override_opts = {
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
          },
        },
      },
    },
  }

  local create_capabilities = function(server_spesific_capabilities)
    local capabilities = server_spesific_capabilities
      or vim.lsp.protocol.make_client_capabilities()
    return require("cmp_nvim_lsp").update_capabilities(capabilities)
  end

  local create_on_attach = function(server_spesific_on_attach)
    return function(client, bufnr)
      local mode = "n"
      local opts = { noremap = true, silent = true }
      local mappings = {
        { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
        {
          "<leader>gi",
          "<cmd>lua vim.lsp.buf.implementation()<CR>",
        },
        {
          "<leader>gs",
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
        { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
        { "<leader>aa", "<cmd>AerialToggle!<CR>" },
      }

      for _, value in pairs(mappings) do
        local key, command = unpack(value)
        vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
      end

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      -- Toggle on some lsp based plugins on attach
      require("illuminate").on_attach(client)

      if client.server_capabilities.documentSymbolProvider then
        require("aerial").on_attach(client, bufnr)
        require("nvim-navic").attach(client, bufnr)
      end

      if server_spesific_on_attach then
        server_spesific_on_attach(client, bufnr)
      end
    end
  end

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing lsp server: " .. name)
      server:install()
    end
  end

  local setup_server = function(server)
    local opts = server:get_default_options()
    local extra_opts = server_spesific_opts[server.name] or {}

    -- Combine possible capablities and on_attach with base opts. Override any other
    -- opts from server spesific config
    opts.capabilities = create_capabilities(extra_opts.capabilities)
    opts.on_attach = create_on_attach(extra_opts.on_attach)
    opts = vim.tbl_extend("force", opts, extra_opts.override_opts or {})

    server:setup(opts)
  end

  lsp_installer.on_server_ready(setup_server)

  -- setup better ui for lsp actions
  require("dressing").setup()
end

return {
  packageName,
  requires = requires,
  config = config,
  commit = "c13ea61d85e2170af35c06b47bcba143cf2f244b",
}
