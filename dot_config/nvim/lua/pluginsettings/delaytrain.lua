local packageName = "ja-ford/delaytrain.nvim"

local config = function()
  require("delaytrain").setup({
    delay_ms = 500,
    grace_period = 3,
    keys = {
      ["nvi"] = { "h", "j", "k", "l", "b", "e", "w", "W" },
    },
  })
end

return {
  packageName,
  config = config,
}
