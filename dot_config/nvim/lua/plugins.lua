-- Automatically ensure that packer.nvim is installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.api.nvim_command("packadd packer.nvim")
end

-- Run PackerCompile each time this file is edited
require("utils").create_autogroup("RunPackerCompileAfterEditingPlugins", {
    "BufWritePost *lua/plugins.lua,*lua/pluginsettings/* PackerCompile"
})

-- Load plugins
local plugins = require("packer").startup(function(use)

    -- Manage packer itself
    use "wbthomason/packer.nvim"

    -- Filetree view and icons
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = [[ require("pluginsettings/nvim-tree") ]]
    }

    -- Text editing
    use {
        "mhartington/formatter.nvim",
        config = [[ require("pluginsettings/formatter") ]]
    }
    use {"b3nj5m1n/kommentary", config = [[ require("pluginsettings/kommentary") ]]}
    use "npxbr/glow.nvim"
    use "plasticboy/vim-markdown"
    use "dbeniamine/todo.txt-vim"
    use "lervag/vimtex"

    -- Visual
    use "sainnhe/edge"
    use {"lukas-reineke/indent-blankline.nvim"}
    use {"kdav5758/TrueZen.nvim", config = [[ require("pluginsettings/truezen") ]]}
    use {"edluffy/specs.nvim", config = [[ require("pluginsettings/specs") ]]}
    -- TODO: not working investigate

    -- Statusline
    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("lualine").setup {options = {theme = "onelight"}}
            -- TODO: setup more visual break between splits
        end
    }

    -- Git, could be replaced with lua versions
    use "airblade/vim-gitgutter"
    use "tpope/vim-fugitive"
    -- TODO: Replace + add git blame virtual texts

    -- Autocomplete
    local compe = "hrsh7th/nvim-compe"
    use {compe, config = [[ require("pluginsettings/nvim-compe") ]]}
    use {"tzachar/compe-tabnine", run = "./install.sh", requires = {compe}}
    use {"onsails/lspkind-nvim", config = function() require("lspkind").init() end}

    -- Treesitter
    local treesitter = "nvim-treesitter/nvim-treesitter"
    use {
        treesitter,
        run = ":TSUpdate",
        config = [[ require("pluginsettings/nvim-treesitter") ]]
    }
    use {"p00f/nvim-ts-rainbow", requires = {treesitter}}

    -- Language server tools
    local lsp = "neovim/nvim-lspconfig"
    use {lsp, config = [[ require("pluginsettings/nvim-lspconfig") ]]}
    use {"kabouzeid/nvim-lspinstall", requires = {lsp}}
    use {
        "glepnir/lspsaga.nvim",
        requires = {lsp},
        config = [[ require("pluginsettings/lspsaga") ]]
    }

    -- Fuzzy finder
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = [[ require("pluginsettings/telescope") ]]
    }

    -- Security stuff
    use "https://gitlab.com/craftyguy/vim-redact-pass.git"
    use {
        "lambdalisue/suda.vim",
        config = function() vim.cmd("let g:suda_smart_edit = 1") end
    }
end)

return plugins
