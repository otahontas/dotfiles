local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local buf_map = require("utils").buf_map

    -- Navigation
    buf_map(
      bufnr,
      "n",
      "]c",
      "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
      { expr = true, suffix = "" }
    )

    buf_map(
      bufnr,
      "n",
      "[c",
      "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
      { expr = true, suffix = "" }
    )

    -- Actions
    buf_map(bufnr, "n", "<leader>sh", ":Gitsigns stage_hunk")
    buf_map(bufnr, "n", "<leader>rh", ":Gitsigns reset_hunk")
  end
  local options = {
    on_attach = on_attach,
    current_line_blame = true,
  }
  require("gitsigns").setup(options)
end

return {
  packageName,
  requires = requires,
  config = config,
}
