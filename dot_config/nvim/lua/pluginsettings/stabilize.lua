local packageName = "luukvbaal/stabilize.nvim"

-- TODO: remove when nvim 0.9 is released
local config = function()
  require("stabilize").setup({
    -- Allow stabilizing windows spawned by autocmds
    nested = "QuickFixCmdPost,DiagnosticChanged *",
  })
end

return {
  packageName,
  config = config,
}
