local conf = require("core.conf")
local fn = vim.fn

local packer = { "wbthomason/packer.nvim" }

local install = function()
  local installPath = conf.xdgDataHome .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(installPath)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', installPath})
  end
end

local getStartup = function()
    return require("packer").startup
end

return { packer = packer, install = install, getStartup = getStartup }
