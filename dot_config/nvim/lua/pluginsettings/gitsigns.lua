local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })
    map({ "n", "v" }, "<leader>sh", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>rh", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>ph", gs.preview_hunk)
    map("n", "<leader>bl", gs.toggle_current_line_blame)
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
