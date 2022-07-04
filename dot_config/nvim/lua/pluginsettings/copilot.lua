local packageName = "github/copilot.vim"

local run = ":Copilot setup"

-- use node v16 from fnm
vim.g.copilot_node_command =
  "~/Library/Application Support/fnm/node-versions/v16.15.1/installation/bin/node"

return {
  packageName,
  run = run,
  commit = "c2e75a3a7519c126c6fdb35984976df9ae13f564",
}
