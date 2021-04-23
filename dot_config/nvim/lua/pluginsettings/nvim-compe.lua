-- Enable compe
vim.o.completeopt = "menuone,noselect"

-- Setup compe
require"compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        buffer = true,
        path = true,
        calc = true,
        spell = true,
        nvim_lsp = true,
        nvim_lua = true,
        tabnine = true,
        tags = false,
        omni = false,
        vsnip = false
    }
}

-- TODO:
-- - auto import
