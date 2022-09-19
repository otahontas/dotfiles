local packageName = "lewis6991/spellsitter.nvim"

-- TODO: remove when 0.8 released
local config = function()
  require("spellsitter").setup()
end

return {
  packageName,
  config = config,
}
