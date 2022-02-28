local packageName = "williamboman/nvim-lsp-installer"

local requires = {
	"neovim/nvim-lspconfig",
}

local config = function()
	local lsp_installer = require("nvim-lsp-installer")
	local lspconfig = require("lspconfig")

	local servers = {
		"tsserver",
		"sumneko_lua",
	}

	local base_config = {
		on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"<leader>wa",
				"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
				opts
			)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"<leader>wr",
				"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
				opts
			)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"<leader>wl",
				"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
				opts
			)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			-- vim.api.nvim_set_current_dir(client.config.root_dir)
		end,
	}

	local extra_configs = {
		tsserver = {},
		sumneko_lua = {
			root_dir = lspconfig.util.root_pattern("stylua.toml") or lspconfig.util.find_git_ancestor(),
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/**/*.lua")] = true,
						},
						maxPreload = 10000,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
	}

	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing lsp server: " .. name)
			server:install()
		end
	end

	local setup_server = function(server)
		local opts = server:get_default_options()
		local nvim_cmp_settings = {
			capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		}
		opts = vim.tbl_deep_extend("force", opts, nvim_cmp_settings)
		opts = vim.tbl_deep_extend("force", opts, base_config)
		opts = vim.tbl_deep_extend("force", opts, extra_configs[server.name])
		server:setup(opts)
	end

	lsp_installer.on_server_ready(setup_server)
end

return { packageName, requires = requires, config = config }
