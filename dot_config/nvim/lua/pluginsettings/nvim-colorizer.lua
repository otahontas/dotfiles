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

return {
  packageName,
  config = config,
  commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
}

-- TODO: replace with faster alternative
