local packageName = "github/copilot.vim"

local config = function()
  vim.g.copilot_node_command = "node16"
end

local run = ":Copilot setup"

return {
  packageName,
  config = config,
  run = run,
}
