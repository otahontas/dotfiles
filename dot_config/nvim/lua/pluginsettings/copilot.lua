local packageName = "zbirenbaum/copilot.lua"

local event = "VimEnter"

local config = function()
  vim.defer_fn(function()
    require("copilot").setup({
      copilot_node_command = "node16",
    })
  end, 100)
end

return {
  packageName,
  event = event,
  config = config,
}
