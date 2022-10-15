local packageName = "lewis6991/gitsigns.nvim"

local requires = "nvim-lua/plenary.nvim"

local config = function()
  local on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local hunk = function(keybinding, mode)
      if vim.wo.diff then
        return keybinding
      end
      local hunk_func
      if mode == "next" then
        hunk_func = gs.next_hunk
      else
        hunk_func = gs.prev_hunk
      end
      vim.schedule(function()
        hunk_func()
      end)
      return "<Ignore>"
    end

    local opts = { buffer = bufnr }
    local next = "]c"
    local prev = "[c"
    local next_func = function()
      hunk(next, "next")
    end
    local prev_func = function()
      hunk(prev, "prev")
    end
    local hunk_opts = vim.tbl_extend("error", opts, { silent = true })
    vim.keymap.set("n", next, next_func, hunk_opts)
    vim.keymap.set("n", prev, prev_func, hunk_opts)
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
