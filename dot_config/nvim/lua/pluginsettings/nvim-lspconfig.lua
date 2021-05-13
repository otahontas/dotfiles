local map = require("utils").map

-- Setup keymaps to be enabled for langauge servers
local on_attach = function(client)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()")
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()")
    map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()")
    map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()")
    map("n", "<leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
    map("n", "<leader>wl", "<cmd>lua vim.lsp.buf.remove_workspace_folder()")
    map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()")

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        ]], false)
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- base setup for all
local base_config = {on_attach = on_attach}

-- Custom settings for different language servers
local lua_extra_config = {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            }
        }
    }
}

-- Add better filetype matchers for some servers
local filetypes = {
    bashls = {"sh"},
    dockerls = {"Dockerfile", "dockerfile"},
    efm = {"markdown", "python", "sh"},
    cssls = {"css", "scss", "less"},
    pyls = {"python"},
    jsonls = {"json"},
    tsserver = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    html = {"html"},
    texlab = {"tex", "bib"},
    clangd = {"c", "cpp"},
    yamlls = {"yaml"}
}

-- Get all installed servers
require("lspinstall").setup()
local servers = require("lspinstall").installed_servers()

-- Setup each server with keymaps, merge extra settings if needed
for _, server in pairs(servers) do
    local config = base_config
    if server == "lua" then for k, v in pairs(lua_extra_config) do config[k] = v end end
    base_config.filetypes = filetypes[server]
    require("lspconfig")[server].setup(config)
end
