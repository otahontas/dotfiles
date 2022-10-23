local conf = require("core.conf")

-- Setup packer if not installed
local installPath = conf.xdgDataHome .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(installPath)) > 0 then
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    installPath,
  })
end

-- Setup plugin loader
local trimLuaExtension = function(filename)
  return filename:gsub("%.lua$", "")
end

local hasLuaExtension = function(filename)
  return filename:match("%.lua$") ~= nil
end

local loadPlugins = function(use)
  use({ "wbthomason/packer.nvim" })

  local dir = conf.xdgConfigHome .. "/lua/pluginsettings"
  for _, file in pairs(vim.fn.readdir(dir)) do
    if hasLuaExtension(file) then
      local name = trimLuaExtension(file)
      local plugin_loaded, plugin = pcall(require, "pluginsettings." .. name)
      if plugin_loaded then
        use(plugin)
      else
        error("Error loading plugin " .. name, 1)
      end
    end
  end
end

-- Attach plugin loader and load plugins
return require("packer").startup(loadPlugins)
