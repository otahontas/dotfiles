local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ "n", "v" }, "<leadersh", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>rh", ":Gitsigns reset_hunk<CR>")
  end
  local options = {
    on_attach = on_attach,
    current_line_blame = true,
  }
  require("gitsigns").setup(options)
end

return { packageName, requires = requires, config = config }
