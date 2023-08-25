local packageName = "jackMort/ChatGPT.nvim"

local requires = {
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
}

local config = function()
  require("chatgpt").setup({
    api_key_cmd = "op read op://private/openai-nvim/credential --no-newline",
  })
end

return {
  packageName,
  requires = requires,
  config = config,
}
