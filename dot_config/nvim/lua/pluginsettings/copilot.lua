local packageName = "github/copilot.vim"

local run = ":Copilot setup"

-- NOTE: ensure this is available in path
vim.g.copilot_node_command = "node16"

return {
  packageName,
  run = run,
  commit = "1bfbaf5b027ee4d3d3dbc828c8bfaef2c45d132d",
}
