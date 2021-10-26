-- Enable compe
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"

local lspkind = require("lspkind")
-- Setup compe
local settings = {
    snippet = {expand = function(args) require("luasnip").lsp_expand(args.body) end},
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

require("nvim-autopairs.completion.cmp").setup(
    {
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
        auto_select = true, -- automatically select the first item
        insert = false, -- use insert confirm behavior instead of replace
        map_char = { -- modifies the function or method delimiter by filetypes
            all = "(",
            tex = "{"
        }
    })
