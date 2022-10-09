local packageName = "luukvbaal/stabilize.nvim"

-- TODO: remove when nvim 0.9 is released
local config = function()
  require("stabilize").setup({
    nested = "QuickFixCmdPost,DiagnosticChanged *",
  })
end

return {
  packageName,
  config = config,
}
