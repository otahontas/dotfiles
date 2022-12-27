local packageName = "ruifm/gitlinker.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local gitlinker = require("gitlinker")
  gitlinker.setup()
  vim.keymap.set("n", "<leader>go", function()
    gitlinker.get_repo_url({
      action_callback = require("gitlinker.actions").open_in_browser,
    })
  end, { silent = true })
end

return {
  packageName,
  requires = requires,
  config = config,
}
