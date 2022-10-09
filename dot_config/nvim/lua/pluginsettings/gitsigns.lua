local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local go_to_hunk = function(keybinding, mode)
      if vim.wo.diff then
        return keybinding
      end
      vim.schedule(function()
        gs[mode]()
      end)
      return "<Ignore>"
    end

    local opts = { buffer = bufnr }
    local next_kb = "]c"
    local prev_kb = "[c"
    local hunk_opts = vim.tbl_extend("error", opts, { silent = true })
    vim.keymap.set("n", next_kb, go_to_hunk(next_kb, "next_hunk"), hunk_opts)
    vim.keymap.set("n", prev_kb, go_to_hunk(prev_kb, "prev_hunk"), hunk_opts)
    vim.keymap.set({ "n", "v" }, "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", opts)
    vim.keymap.set({ "n", "v" }, "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>", opts)
    vim.keymap.set("n", "<leader>ph", gs.preview_hunk, opts)
    vim.keymap.set("n", "<leader>bl", gs.toggle_current_line_blame, opts)
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
