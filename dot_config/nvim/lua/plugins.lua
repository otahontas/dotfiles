-- Shared

-- default denols root dir includes .git, which makes it run for some projects, where
-- only tsserver should be running. This makes denols run only for deno-based projects.
-- typescript-tools uses this to decide whether it should close itself when denols is
-- running
local denols_root_pattern = function(fname)
  return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(fname)
end

local aesthetics = {
  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Make sure colorscheme is loaded before all the other plugins
    opts = {
      integrations = {
        -- TODO: check other integrations
        mason = true,
        neotest = true,
      },
    },
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- indent marks
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      -- setup multiple indent colors
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },
  -- lsp context breadcrumps
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      theme = "catppuccin-latte",
    },
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "catppuccin",
    },
  },
  -- better looking diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("tiny-inline-diagnostic").setup()
    end,
  },
}

local treesitter = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {},
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        endwise = { enable = true },
      })

      -- Some filetypes aren't recognized by default
      vim.treesitter.language.register("yaml", "yaml.docker-compose")
      vim.treesitter.language.register("yaml", "yaml.github-action")

      -- folding
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
    setup = function()
      -- disable hlargs if a language server with semantic token capabilities is attached to a buffer
      vim.api.nvim_create_augroup("LspAttach_hlargs", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_hlargs",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local caps = client.server_capabilities
          if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            require("hlargs").disable_buf(args.buf)
          end
        end,
      })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}

local navigating = {
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {
        "<leader>ee",
        "<cmd>:Oil .<cr>", -- open from working dir
        { silent = true },
      },
      {
        "<leader>en",
        "<cmd>:Oil<cr>", -- open from current files dir
        { silent = true },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
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
  {
    "willothy/flatten.nvim",
    lazy = false,
    priotity = 1001,
    opts = {
      one_per = {
        wezterm = true,
      },
    },
  },
}

local editing = {
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    lazy = false,
    build = ":COQdeps",
    init = function()
      vim.g.coq_settings = {
        auto_start = true,
        clients = {
          tree_sitter = { enabled = false },
          tags = { enabled = false },
          tmux = { enabled = false },
        },
        keymap = { recommended = false, jump_to_mark = "<c-e>" },
      }
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "github/copilot.vim" },
    },
  },
  { "echasnovski/mini.pairs", version = "*", opts = {} },
  { "echasnovski/mini.surround", version = "*", opts = {} },
  {
    "lambdalisue/suda.vim",
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
}

local git = {
  {
    "linrongbin16/gitlinker.nvim",
    opts = {},
    keys = {
      {
        "<leader>gy",
        "<cmd>GitLink<cr>",
        { silent = true },
      },
      {
        "<leader>go",
        "<cmd>GitLink!<cr>",
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
      end,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "echasnovski/mini-git", version = "*", main = "mini.git", opts = {} },
}

local tools = {
  { "williamboman/mason.nvim", opts = {} },
}

local lsp = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Global mappings
      vim.keymap.set("n", "<space>dq", vim.diagnostic.setloclist)

      -- Load this when lsp is attached to buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
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
        end,
      })

      -- Servers and server spesific options
      local servers = {
        -- without any extra settings
        { "bashls" },
        { "sourcery" },
        { "taplo" },
        { "pyright" },
        { "metals" },
        { "svelte" },
        { "astro" },
        -- with some extra settings
        {
          "tailwindcss",
          {
            opts = {
              root_dir = require("lspconfig.util").root_pattern(
                "tailwind.config.js",
                "tailwind.config.cjs",
                "tailwind.config.mjs",
                "tailwind.config.ts"
              ),
            },
          },
        },
        {
          "clangd",
          {
            opts = {
              cmd = {
                "clangd",
                "--offset-encoding=utf-16",
                "--enable-config",
              },
              capabilities = {
                offsetEncoding = { "utf-16" },
              },
            },
          },
        },
        {
          "ruff_lsp",
          {
            opts = {
              on_attach = function(client)
                -- disable settings that should be handled with pyright
                client.server_capabilities.hoverProvider = false
              end,
            },
          },
        },
        {
          "docker_compose_language_service",
          opts = {
            on_attach = function(_, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("FormatDockerComposeOnSave", {}),
                callback = function()
                  vim.lsp.buf.format()
                end,
                buffer = bufnr,
              })
            end,
          },
        },
        {
          "dockerls",
          opts = {
            on_attach = function(_, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("FormatDockerfileOnSave", {}),
                callback = function()
                  vim.lsp.buf.format()
                end,
                buffer = bufnr,
              })
            end,
          },
        },
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
              -- load type queries
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
            filetypes = {
              -- run server also with custom filetypes
              "yaml",
              "yaml.docker-compose",
              "yaml.github-action",
            },
            settings = {
              yaml = {
                schemaStore = {
                  -- built-in yaml ls schemaStore support must be disabled to use
                  -- schemasstore plugin and its advanced options like `ignore`.
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
      "ms-jpq/coq_nvim", -- ensures we can set up lsp sources for autocompletion
      "williamboman/mason-lspconfig.nvim", -- ensures automatic installation works
      "b0o/SchemaStore.nvim", -- schemas for jsonls and yamlls
    },
  },
  {
    "pmizio/typescript-tools.nvim", -- typescript extra tools
    opts = {
      on_attach = function(client, bufnr)
        -- don't load tsserver for deno projects
        if denols_root_pattern(vim.fn.getcwd()) then
          client.stop()
          return
        end
        -- load type queries
        require("twoslash-queries").attach(client, bufnr)
      end,
    },
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
  },
  {
    "simrat39/rust-tools.nvim", -- rust extra tools
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
          },
        },
        on_attach = function(_, bufnr)
          vim.keymap.set(
            "n",
            "<leader>ha",
            require("rust-tools").hover_actions.hover_actions,
            { buffer = bufnr }
          )
          vim.schedule(function()
            require("rust-tools").inlay_hints.set()
          end)
        end,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "ts_ls", -- mason doesn't automatically pick up tsserver wrapper from typescript-tools.nvim plugin
      },
    },
    dependencies = { "williamboman/mason.nvim" },
  },
}

local lintingAndFormatting = {
  {
    "mhartington/formatter.nvim",
    config = function()
      -- setup

      -- same prettier / denofmt setup runs for many different filetypes:
      local javascriptOrTypescriptFormatting = function()
        -- trust that lspconfig is loaded so we can check for root patterns
        -- for current buffer
        -- in deno projects use deno formatter, otherwise prettier
        if denols_root_pattern(vim.api.nvim_buf_get_name(0)) then
          return require("formatter.filetypes.javascript").denofmt()
        end
        -- otherwise use prettier
        return require("formatter.filetypes.javascript").prettier()
      end

      local sqlfluff = function()
        return {
          exe = "sqlfluff",
          args = {
            "format",
            "--dialect",
            "postgres",
            "--disable-progress-bar",
            "--nocolor",
            "-",
          },
          stdin = true,
          ignore_exitcode = true,
        }
      end

      require("formatter").setup({
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          javascript = { javascriptOrTypescriptFormatting },
          typescript = { javascriptOrTypescriptFormatting },
          javascriptreact = { javascriptOrTypescriptFormatting },
          typescriptreact = { javascriptOrTypescriptFormatting },
          rust = { require("formatter.filetypes.rust").rustfmt },
          sh = { require("formatter.filetypes.sh").shfmt },
          sql = { sqlfluff },
          cpp = { require("formatter.filetypes.cpp").clangformat },
          cuda = { require("formatter.filetypes.cpp").clangformat },
          python = { require("formatter.filetypes.python").black },

          -- fallback for all filetypes
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })

      -- autoformat
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("RunFormatting", {}),
        callback = function()
          vim.cmd("FormatWrite")
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    ft = { "dockerfile", "lua", "sql", "yaml.github-action" },
    config = function()
      -- setup
      local linters_by_ft =
        { -- Note: remember to add filetype to lazy table (above) too
          dockerfile = {
            "hadolint",
          },
          lua = {
            "luacheck",
          },
          sql = {
            "sqlfluff",
          },
          ["yaml.github-action"] = {
            "actionlint",
          },
        }
      require("lint").linters_by_ft = linters_by_ft

      -- Setup semi-lazy linting (not on every keystroke) for given filetypes
      local linternames = {}
      for k, _ in pairs(linters_by_ft) do
        table.insert(linternames, k)
      end
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = linternames,
        group = vim.api.nvim_create_augroup("SetupLintingWhenOpeningFiletype", {}),
        callback = function(opts)
          -- add autocmd for this buffer
          vim.api.nvim_create_autocmd(
            { "InsertEnter", "InsertLeave", "BufWritePost" },
            {
              buffer = opts.buf,
              callback = function()
                require("lint").try_lint()
              end,
            }
          )
        end,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- formatters
        "shfmt",
        "stylua",
        "prettier",
        "black",
        "clang-format",
        -- linters
        "shellcheck", -- goes through bash-lsp!
        "hadolint",
        "luacheck",
        "actionlint",
        "sqlfluff",
      },
    },
    dependencies = { "williamboman/mason.nvim", "mhartington/formatter.nvim" },
  },
}

-- combine plugins
local plugins = {}
for _, pluginGroup in ipairs({
  aesthetics,
  treesitter,
  navigating,
  editing,
  git,
  tools,
  lsp,
  lintingAndFormatting,
}) do
  table.insert(plugins, pluginGroup)
end
return plugins
