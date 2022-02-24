-- Load plugins
local plugins = require("packer").startup(function(use)
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("lualine").setup {options = {theme = "onelight"}}
        end
    }
    use {
        "ruifm/gitlinker.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("gitlinker").setup() end
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require("gitsigns").setup({current_line_blame = true})
        end
    }
    use {
        "tpope/vim-fugitive",
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>G", ":Git ",
                                    {noremap = true, silent = false})
        end
    }
    local cmp = "hrsh7th/nvim-cmp"
    use {cmp, config = [[ require("pluginsettings/nvim-cmp") ]]}
    use {"hrsh7th/cmp-buffer", requires = {cmp}}
    use {"hrsh7th/cmp-nvim-lsp", requires = {cmp}}
    use {"petertriho/cmp-git", requires = {{cmp}, {"nvim-lua/plenary.nvim"}}}
    use {"tzachar/cmp-tabnine", run = "./install.sh", requires = {cmp}}
    use {"onsails/lspkind-nvim", requires = {cmp}}
    use {"L3MON4D3/LuaSnip", requires = {cmp}}
    use {"saadparwaiz1/cmp_luasnip", requires = {cmp}}
    local treesitter = "nvim-treesitter/nvim-treesitter"
    use {
        treesitter,
        run = ":TSUpdate",
        config = [[ require("pluginsettings/nvim-treesitter") ]]
    }
    use {"p00f/nvim-ts-rainbow", requires = {treesitter}}
    use {"windwp/nvim-ts-autotag", requires = {treesitter}}
    local lsp = "neovim/nvim-lspconfig"
    use {lsp, config = [[ require("pluginsettings/nvim-lspconfig") ]]}
    use {"williamboman/nvim-lsp-installer", requires = {lsp}}
    use {
        "tami5/lspsaga.nvim",
        requires = {lsp},
        config = [[ require("pluginsettings/lspsaga") ]]
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = [[ require("pluginsettings/telescope") ]]
    }
    use "rafamadriz/friendly-snippets"

    if Packer_bootstrap then require("packer").sync() end
end)

return plugins
