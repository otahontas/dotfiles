local utils = require("utils")
local map = utils.map

local packageName = "williamboman/nvim-lsp-installer"

local requires = {
    "neovim/nvim-lspconfig"
}

local on_attach = function(client)
    -- Setup keymaps
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

    if client.resolved_capabilities.document_highlight then
        -- Set background highlighting for references
        local refopts = {"LspReferenceRead", "LspReferenceText", "LspReferenceWrite"}
        for _, opt in pairs(refopts) do
            vim.api.nvim_command("highlight " .. opt .. " cterm=bold ctermbg=red guibg=LightYellow")
        end
        -- Set up highlighting
        require("utils").create_autogroup("LspDocumentHightlight", {
            "CursorHold <buffer> lua vim.lsp.buf.document_highlight()",
            "CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
        }, "* <buffer>")
    end
end

local config = function()
  local lsp_installer = require("nvim-lsp-installer")
  local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "graphql",
    "html",
    "jsonls",
    "tsserver",
    "sumneko_lua",
    "sqlls",
    "yamlls"
  }
  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
  
  lsp_installer.on_server_ready(function(server)
      local opts = server:get_default_options()
      server:setup(opts)
  end)
end

return { packageName, requires = requires, config = config }
