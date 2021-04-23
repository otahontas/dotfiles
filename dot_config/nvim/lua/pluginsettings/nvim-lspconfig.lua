-- Setup keymaps to be enabled for langauge servers
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>wr",
                   "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl",
                   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                   opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
                   opts)

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
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

-- This should match filetypes of linters set in efm config
local efm_extra_config = {filetypes = {"markdown", "python", "sh"}}

-- Get all installed servers
require"lspinstall".setup()
local servers = require"lspinstall".installed_servers()

-- Setup each server with keymaps, merge extra settings if needed
for _, server in pairs(servers) do
    local config = base_config
    if server == "lua" then for k, v in pairs(lua_extra_config) do config[k] = v end end
    if server == "efm" then for k, v in pairs(efm_extra_config) do config[k] = v end end
    require"lspconfig"[server].setup(config)
end
