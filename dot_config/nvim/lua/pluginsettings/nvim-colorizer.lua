local packageName = "norcalli/nvim-colorizer.lua"

local config = function()
  require("colorizer").setup({ "*" }, {
    RGB = true,
    RRGGBB = true,
    names = true,
    RRGGBBAA = true,
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
  })
end

return { packageName, config = config }
