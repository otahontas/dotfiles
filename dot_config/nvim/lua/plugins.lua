-- Automatically ensure that packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path
    })
    execute "packadd packer.nvim"
end

-- Run PackerCompile each time this file is edited
require("utils").create_autogroup("RunPackerCompileAfterEditingPlugins",
                                  "BufWritePost *lua/plugins.lua,*lua/pluginsettings/* PackerCompile")

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

    -- Visual
    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    use {"kdav5758/TrueZen.nvim", config = [[ require("pluginsettings/truezen") ]]}
    use "sainnhe/edge"

    -- Statusline
    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("lualine").setup {options = {theme = "onelight"}}
        end
    }

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
end)

return plugins
