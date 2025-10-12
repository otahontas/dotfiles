local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = "Disable line numbers in terminal",
  group = augroup("DisableLineNumbersInTerminal", {}),
  pattern = "*",
})

local create_set_relative_number = function(value)
  local set_relative_number = function()
    if not vim.opt.number:get() then
      return
    end
    vim.opt_local.relativenumber = value
  end
  return set_relative_number
end
local augroup_toggle_relative_numbers = augroup("ToggleRelativeNumbers", {})
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter", }, {
  callback = create_set_relative_number(true),
  desc = "Enable relative numbers when returning to buffer and not in insert mode",
  group = augroup_toggle_relative_numbers,
  pattern = "*",
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave", }, {
  callback = create_set_relative_number(false),
  desc = "Disable relative numbers when leaving buffer, in insert mode or in cmdline",
  group = augroup_toggle_relative_numbers,
  pattern = "*",
})
