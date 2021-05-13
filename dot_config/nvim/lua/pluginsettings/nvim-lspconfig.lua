-- Stuff to enable on Lsp client attach
local on_attach = function(client)
    -- Setup keymaps to be enabled for langauge servers
    local map = require("utils").map
    local base = "<cmd>lua vim.lsp.buf."
    map("n", "gD", base .. "declaration()")
    map("n", "gi", base .. "implementation()")
    map("n", "<leader>wa", base .. "add_workspace_folder()")
    map("n", "<leader>wr", base .. "remove_workspace_folder()")
    map("n", "<leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
    map("n", "<leader>wl", base .. "remove_workspace_folder()")
    map("n", "<leader>D", base .. "type_definition()")

    -- Set working directory of current window to clients root dir
    vim.api.nvim_command("lcd " .. client.config.root_dir)

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

-- Add better filetype matchers for servers
local filetypes = {
    bash = {"sh"},
    dockerfile = {"Dockerfile", "dockerfile"},
    efm = {"markdown", "python", "sh"},
    css = {"css", "scss", "less"},
    python = {"python"},
    json = {"json"},
    typescript = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    html = {"html"},
    lua = {"lua"},
    latex = {"tex", "bib"},
    cpp = {"c", "cpp"},
    yaml = {"yaml"},
    rust = {"rust"}
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
