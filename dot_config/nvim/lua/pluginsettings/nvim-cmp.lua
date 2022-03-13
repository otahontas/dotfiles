local packageName = "hrsh7th/nvim-cmp"

local requires = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "rafamadriz/friendly-snippets",
}

local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  local sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }
  local options = {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(sources),
    formatting = { format = lspkind.cmp_format({ mode = "symbol", maxwidth = 50 }) },
  }
  vim.o.completeopt = "menu,menuone,noselect"

  cmp.setup(options)

  -- Add snippets for react files
  vim.cmd([[
    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.javascriptreact = ['javascript']
    let g:vsnip_filetypes.typescriptreact = ['typescript']
  ]])

  -- Use buffer source for `/`
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
  )
end

return {
  packageName,
  requires = requires,
  config = config,
}
