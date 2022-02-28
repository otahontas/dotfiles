local packageName = "hrsh7th/nvim-cmp"

local requires = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  "neovim/nvim-lspconfig",
}

local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
  }
  local settings = {
    sources = cmp.config.sources(sources),
    formatting = { format = lspkind.cmp_format({ mode = "symbol", maxwidth = 50 }) },
  }
  vim.o.completeopt = "menu,menuone,noselect"
  cmp.setup(settings)
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
