
-- base setup for all
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
local base_config = {on_attach = on_attach, capabilities = capabilities}

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

-- Server settings
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local config = base_config
    if server.name == "sumneko_lua" then
        for k, v in pairs(lua_extra_config) do config[k] = v end
    end
    base_config.filetypes = filetypes[server]
    server:setup(config)
end)
