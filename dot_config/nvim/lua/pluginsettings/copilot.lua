local packageName = "github/copilot.vim"

local run = ":Copilot setup"

-- NOTE: ensure this is available in path
vim.g.copilot_node_command = "node16"

return {
  packageName,
  run = run,
}
