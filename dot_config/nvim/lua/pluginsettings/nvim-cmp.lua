-- Enable compe
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"

local snip = require("luasnip")
local snippet_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/friendly-snippets"

require("luasnip/loaders/from_vscode").load({paths = {snippet_path}})

local lspkind = require("lspkind")
-- Setup compe
local settings = {
    snippet = {expand = function(args) snip.lsp_expand(args.body) end},
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.config.disable,
        ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
        {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}, {name = "cmp_git"},
        {name = "cmp_tabnine"}
    }),
    formatting = {format = lspkind.cmp_format({with_text = false, maxwidth = 50})}
}
cmp.setup(settings)

require("cmp_git").setup({
    -- defaults
    filetypes = {"gitcommit"},
    github = {
        issues = {
            filter = "all", -- assigned, created, mentioned, subscribed, all, repos
            limit = 100,
            state = "open" -- open, closed, all
        },
        mentions = {limit = 100}
    },
    gitlab = {
        issues = {
            limit = 100,
            state = "opened" -- opened, closed, all
        },
        mentions = {limit = 100},
        merge_requests = {
            limit = 100,
            state = "opened" -- opened, closed, locked, merged
        }
    }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
