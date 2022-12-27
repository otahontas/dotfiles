local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })
    local opts = { buffer = bufnr }
    vim.keymap.set({ "n", "v" }, "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", opts)
    vim.keymap.set({ "n", "v" }, "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>", opts)
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
    vim.keymap.set("n", "<leader>ph", gs.preview_hunk, opts)
    vim.keymap.set("n", "<leader>bl", gs.toggle_current_line_blame, opts)
    vim.keymap.set("n", "<leader>hd", gs.diffthis)
    vim.keymap.set("n", "<leader>hD", function()
      gs.diffthis("~")
    end)
  end

  require("gitsigns").setup({
    on_attach = on_attach,
  })
end

return {
  packageName,
  requires = requires,
  config = config,
}
