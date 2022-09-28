local packageName = "luukvbaal/stabilize.nvim"

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
