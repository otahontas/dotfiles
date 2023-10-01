-- Shared

-- default denols root dir includes .git, which makes it run for some projects, where
-- only tsserver should be running. This makes denols run only for deno-based projects.
-- typescript-tools uses this to decide whether it should close itself when denols is
-- running
local denols_root_pattern = function(fname)
  return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(fname)
end

-- Plugins
return {
  -- Aesthetics
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 999, -- Make sure colorscheme is loaded before all the other plugins
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
    opts = { integrations = { mason = true } },
  },
  { "levouh/tint.nvim", opts = { tint = -90, saturation = 0.1 } },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {},
    config = function()
      -- setup treesitter itself
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        endwise = { enable = true },
      })

      -- setup treesitter based folding
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldlevelstart = 20
    end,
    dependencies = {
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "m-demare/hlargs.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Navigating
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local default_config = require("telescope.config")

      local vimgrep_arguments = { unpack(default_config.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, "--follow")
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--trim")

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "file", "--strip-cwd-prefix", "--hidden" },
          },
        },
      })

      local builtin_pickers = require("telescope.builtin")
      vim.keymap.set("n", "<leader>tt", builtin_pickers.builtin, {})
      vim.keymap.set("n", "<leader>bb", builtin_pickers.buffers, {})
      vim.keymap.set("n", "<leader>km", builtin_pickers.keymaps, {})
      vim.keymap.set("n", "<leader>ff", builtin_pickers.find_files, {})
      vim.keymap.set("n", "<leader>rg", builtin_pickers.live_grep, {})

      telescope.load_extension("fzf")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "farmergreg/vim-lastplace",
  },

  -- Editing
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    build = ":COQdeps",
    config = function()
      vim.g.coq_settings = {
        clients = {
          tree_sitter = { enabled = false },
          tags = { enabled = false },
          tmux = { enabled = false },
        },
        keymap = { recommended = false },
      }
      vim.cmd(":COQnow --shut-up")
    end,
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
    },
  },
  { "echasnovski/mini.comment", version = "*", opts = {} },
  { "echasnovski/mini.pairs", version = "*", opts = {} },
  { "echasnovski/mini.surround", version = "*", opts = {} },
  {
    "lambdalisue/suda.vim",
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  },

  -- Git
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>G", ":G " },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    opts = {},
    keys = {
      {
        "<leader>go",
        function()
          require("gitlinker").get_repo_url({
            action_callback = require("gitlinker.actions").open_in_browser,
          })
        end,
        { silent = true },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })
      end
    },
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },

  -- Installer for third party tools
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "tsserver", -- mason doesn't automatically pick up tsserver from typescript-tools.nvim plugin
      },
    },
    dependencies = { "williamboman/mason.nvim" },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Global mappings
      vim.keymap.set("n", "<space>de", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>dq", vim.diagnostic.setloclist) -- TODO: quicklist vs locllist?

      -- Load this when lsp is attached to buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          -- formatting?
        end,
      })

      -- Servers and server spesific options
      local servers = {
        -- without any extra settings
        { "bashls" },
        { "docker_compose_language_service" },
        { "dockerls" },
        { "gopls" },
        { "pyright" },
        { "sourcery" },
        { "taplo" },
        -- with some extra settings
        {
          "lua_ls",
          opts = {
            settings = {
              Lua = { completion = { callSnippet = "Replace" } },
            },
          },
          before_setup = function()
            require("neodev").setup({})
          end,
        },
        {
          "denols",
          opts = {
            root_dir = denols_root_pattern,
            on_attach = function(client, bufnr)
              require("twoslash-queries").attach(client, bufnr)
            end,
          },
        },
        {
          "jsonls",
          opts = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          },
        },
        {
          "yamlls",
          opts = {
            settings = {
              yaml = {
                schemaStore = {
                  -- You must disable built-in schemaStore support if you want to use
                  -- this plugin and its advanced options like `ignore`.
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          },
        },
        {
          "eslint",
          opts = {
            on_attach = function(_, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("RunEslintFixAllOnSave", {}),
                callback = function()
                  vim.cmd("EslintFixAll")
                end,
                buffer = bufnr,
              })
            end,
          },
        },
      }

      -- Run setup for each server
      for _, server in ipairs(servers) do
        -- name is number indexed field, other (optional) fields are named
        local serverName = server[1]

        if server.before_setup then
          server.before_setup()
        end

        require("lspconfig")[serverName].setup(
          require("coq").lsp_ensure_capabilities(server.opts or {})
        )
      end
    end,

    dependencies = {
      "folke/neodev.nvim", -- Neovim development betterments
      "ms-jpq/coq_nvim", -- ensures setting up lsp autocompletion works
      "williamboman/mason-lspconfig.nvim", -- ensures automatic installation works
      "b0o/SchemaStore.nvim", -- schemas for jsonls and yamlls
    },
  },
  {
    "pmizio/typescript-tools.nvim", -- typescript extra tools
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "marilari88/twoslash-queries.nvim",
        opts = {
          multi_line = true,
        },
      },
    },
    opts = {
      on_attach = function(client, bufnr)
        -- don't load tsserver for deno projects
        if denols_root_pattern(vim.fn.getcwd()) then
          client.stop()
          return
        end
        require("twoslash-queries").attach(client, bufnr)
      end,
    },
  },
}
