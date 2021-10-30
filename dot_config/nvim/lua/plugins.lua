local map = require("utils").map
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end

-- Run PackerCompile each time this file is edited
require("utils").create_autogroup("RunPackerCompileAfterEditingPlugins", {
    "BufWritePost *lua/plugins.lua,*lua/pluginsettings/* source <afile> | PackerCompile"
})

-- Load plugins
local plugins = require("packer").startup(function(use)
    use {"nvim-lua/plenary.nvim"}
    use {
        "mhartington/formatter.nvim",
        config = [[ require("pluginsettings/formatter") ]]
    } -- TODO: replace formatter with efm language server?
    use {"b3nj5m1n/kommentary", config = [[ require("pluginsettings/kommentary") ]]}
    use {"wbthomason/packer.nvim"}
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = [[ require("pluginsettings/nvim-tree") ]]
    }
    use "plasticboy/vim-markdown" -- TODO: is this really needed?
    use {
        "dbeniamine/todo.txt-vim",
        config = function() vim.cmd("let g:Todo_txt_prefix_creation_date=1") end
    }
    use "lervag/vimtex" -- TODO: can plain lsp used instead?
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {"hail2u/vim-css3-syntax"}
    use {"styled-components/vim-styled-components"}
    use "sainnhe/edge"
    use "dstein64/nvim-scrollview"
    use "lukas-reineke/indent-blankline.nvim"
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require"colorizer".setup({"*"}, {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true
            })
        end
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
    use {"kabouzeid/nvim-lspinstall", requires = {lsp}}
    use {
        "tami5/lspsaga.nvim",
        branch = "nvim51",
        requires = {lsp},
        config = [[ require("pluginsettings/lspsaga") ]]
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = [[ require("pluginsettings/telescope") ]]
    }
    use {"mrjones2014/dash.nvim", run = "make install"}
    use "https://gitlab.com/craftyguy/vim-redact-pass.git"
    use {
        "lambdalisue/suda.vim",
        config = function() vim.cmd("let g:suda_smart_edit = 1") end
    }
    use {"pwntester/octo.nvim", config = function() require"octo".setup() end}
    map("n", "<leader>oo", ":Octo ")

    if Packer_bootstrap then require("packer").sync() end
end)

return plugins
