local packageName = "neovim/nvim-lspconfig"

local requires = {
  "b0o/SchemaStore.nvim",
  "folke/lua-dev.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "SmiteshP/nvim-navic",
  "williamboman/mason-lspconfig.nvim",
  "ms-jpq/coq_nvim",
  "ms-jpq/coq.artifacts",
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
    "rust_analyzer",
    "sourcery",
    "sumneko_lua",
    "tailwindcss",
    "taplo",
    "tsserver",
    "yamlls",
  }

  local server_spesific_opts = {
    jsonls = {
      override_opts = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
    },
    sumneko_lua = {
      override_opts = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
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

  local on_attach = function(client, bufnr)
    local bufopts = { silent = true, buffer = bufnr }
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
    if client.name ~= "graphql" then
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
    end
  end
  local lspconfig = require("lspconfig")

  vim.g.coq_settings = {
    auto_start = "shut-up",
    clients = {
      tree_sitter = { enabled = false },
      tags = { enabled = false },
      tmux = { enabled = false },
    },
    keymap = {
      recommended = false,
    },
  }
  local coq = require("coq")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  for _, server in ipairs(servers) do
    local opts = coq.lsp_ensure_capabilities(vim.tbl_deep_extend("force", {
      on_attach = on_attach,
      capabilities = capabilities,
    }, server_spesific_opts[server] or {}))

    if server == "tsserver" then
      require("typescript").setup({
        server = opts,
      })
    elseif server == "sumneko_lua" then
      require("lua-dev").setup({})
      lspconfig[server].setup(opts)
    else
      lspconfig[server].setup(opts)
    end
  end
end

return {
  packageName,
  requires = requires,
  after = after,
  config = config,
}
