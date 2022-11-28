local packageName = "neovim/nvim-lspconfig"

local requires = {
  "b0o/SchemaStore.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "SmiteshP/nvim-navic",
  "williamboman/mason-lspconfig.nvim",
  "ms-jpq/coq_nvim",
  "ms-jpq/coq.artifacts",
  "folke/neodev.nvim",
}

local after = {
  "mason-lspconfig.nvim",
}

local config = function()
  local servers = {
    "bashls",
    "eslint",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "pyright",
    "rome",
    "rust_analyzer",
    "sourcery",
    "sumneko_lua",
    "taplo",
    "tsserver",
    "yamlls",
  }

  local util = require("lspconfig.util")
  local json_schemas = require("schemastore").json.schemas()
  local yaml_schemas = {}
  vim.tbl_map(function(schema)
    yaml_schemas[schema.url] = schema.fileMatch
  end, json_schemas)

  local server_specific_opts = {
    jsonls = {
      settings = {
        json = {
          schemas = json_schemas,
          validate = { enable = true },
        },
      },
    },
    rome = {
      root_dir = util.root_pattern("rome.json"),
      single_file_support = false,
    },
    sumneko_lua = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
    yamlls = {
      settings = {
        yaml = {
          schemas = yaml_schemas,
          customTags = {
            "!And scalar",
            "!And mapping",
            "!And sequence",
            "!If scalar",
            "!If mapping",
            "!If sequence",
            "!Not scalar",
            "!Not mapping",
            "!Not sequence",
            "!Equals scalar",
            "!Equals mapping",
            "!Equals sequence",
            "!Or scalar",
            "!Or mapping",
            "!Or sequence",
            "!FindInMap scalar",
            "!FindInMap mappping",
            "!FindInMap sequence",
            "!Base64 scalar",
            "!Base64 mapping",
            "!Base64 sequence",
            "!Cidr scalar",
            "!Cidr mapping",
            "!Cidr sequence",
            "!Ref scalar",
            "!Ref mapping",
            "!Ref sequence",
            "!Sub scalar",
            "!Sub mapping",
            "!Sub sequence",
            "!GetAtt scalar",
            "!GetAtt mapping",
            "!GetAtt sequence",
            "!GetAZs scalar",
            "!GetAZs mapping",
            "!GetAZs sequence",
            "!ImportValue scalar",
            "!ImportValue mapping",
            "!ImportValue sequence",
            "!Select scalar",
            "!Select mapping",
            "!Select sequence",
            "!Split scalar",
            "!Split mapping",
            "!Split sequence",
            "!Join scalar",
            "!Join mapping",
            "!Join sequence",
          },
        },
      },
    },
  }

  local setup_format_on_save = require("plugins_shared").setup_format_on_save
  local on_attach = function(client, bufnr)
    setup_format_on_save(client, bufnr)

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
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("RunEslintFixAllOnSave", {}),
        callback = function()
          vim.cmd("EslintFixAll")
        end,
        buffer = bufnr,
      })
    end
  end
  local lspconfig = require("lspconfig")

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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

  for _, server in ipairs(servers) do
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if vim.tbl_contains({ "cssls", "html", "jsonls" }, server) then
      capabilities.textDocument.completion.completionItem.snippetSupport = true
    end

    local opts = coq.lsp_ensure_capabilities(
      vim.tbl_deep_extend("keep", server_specific_opts[server] or {}, {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    )

    if server == "tsserver" then
      require("typescript").setup({
        server = opts,
      })
    elseif server == "sumneko_lua" then
      require("neodev").setup({})
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
