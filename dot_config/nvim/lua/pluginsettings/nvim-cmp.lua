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
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
}

local config = function()
  local cmp = require("cmp")

  local sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "nvim_lsp_signature_help" },
  }
  local options = {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-f>"] = cmp.mapping.scroll_docs(-4),
      ["<C-b>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(sources),
    formatting = {
      format = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 44 }),
    },
  }

  -- Options for native complete menu
  vim.o.completeopt = "menu,menuone,noselect"

  cmp.setup(options)

  -- Add some snippets for other filetypes as well
  vim.cmd([[
    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.javascriptreact = ['javascript']
    let g:vsnip_filetypes.typescript = ['javascript']
    let g:vsnip_filetypes.typescriptreact = ['javascript', 'typescript']
  ]])

  -- Use buffer source for `/` for find and replace
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
      { name = "nvim_lsp_document_symbol" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  -- handle autopairs
  cmp.event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
  )
end

return {
  packageName,
  requires = requires,
  config = config,
}
