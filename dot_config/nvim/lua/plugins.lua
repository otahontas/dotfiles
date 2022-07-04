local conf = require("core.conf")
local fn = vim.fn

-- Setup packer if not installed
local installPath = conf.xdgDataHome .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(installPath)) > 0 then
  fn.system({
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
      use(require("pluginsettings" .. "." .. trimLuaExtension(file)))
    end
  end
end

return require("packer").startup(loadPlugins)
