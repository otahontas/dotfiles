local packageName = "zbirenbaum/copilot.lua"

local event = "InsertEnter"

local config = function()
  vim.schedule(function()
    require("copilot").setup({
      suggestion = {
        keymap = {
          accept = "<C-y>",
          next = "<C-k>",
          prev = "<C-j>",
        },
      },
      copilot_node_command = "node16",
    })
  end)
end

return {
  packageName,
  event = event,
  config = config,
}
