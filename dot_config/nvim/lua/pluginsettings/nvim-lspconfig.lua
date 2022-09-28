local packageName = "neovim/nvim-lspconfig"

local requires = {
  "RRethy/vim-illuminate",
  "b0o/SchemaStore.nvim",
  "stevearc/dressing.nvim",
  "folke/lua-dev.nvim",
  "jose-elias-alvarez/typescript.nvim",
}

local after = {
  "mason-lspconfig.nvim",
}

local config = function()
  local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "gopls",
    "graphql",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer", -- TODO: better setup with nvim rstools
    "sourcery",
    "sumneko_lua",
    "tailwindcss",
    "taplo",
    "tsserver",
    "yamlls", -- TODO: kubernetes setup
  }

  local extra_capabilities_for_vscode_langserver = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  }

  local server_spesific_opts = {
    cssls = {
      extra_capabilities = extra_capabilities_for_vscode_langserver,
    },
    html = {
      extra_capabilities = extra_capabilities_for_vscode_langserver,
    },
    jsonls = {
      extra_capabilities = extra_capabilities_for_vscode_langserver,
      override_opts = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      },
    },
    sumneko_lua = {
      override_opts = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },
  }

  local create_capabilities = function(extra_capabilities)
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      extra_capabilities or {}
    )
    return require("cmp_nvim_lsp").update_capabilities(capabilities)
  end

  local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)

    -- TODO: set range code actions separately

    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    -- Toggle on some lsp based plugins on attach
    require("illuminate").on_attach(client)

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  end

  local lspconfig = require("lspconfig")

  for _, lsp in ipairs(servers) do
    local server_opts = server_spesific_opts[lsp] or {}
    local opts = vim.tbl_deep_extend("force", {
      on_attach = on_attach,
      capabilities = create_capabilities(server_opts.extra_capabilities),
    }, server_opts.override_opts or {})
    if lsp == "tsserver" then
      -- extra setup
      require("typescript").setup({
        server = opts,
      })
    else
      lspconfig[lsp].setup(opts)
    end
  end

  -- setup dev env
  require("lua-dev").setup()

  -- setup better ui for lsp actions
  require("dressing").setup()
end

return {
  packageName,
  requires = requires,
  config = config,
  after = after,
}
