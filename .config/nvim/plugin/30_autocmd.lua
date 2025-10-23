local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Global autocmds that should always be on

-- Disable line numbers when entering terminal mode
autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = "Disable line numbers in terminal",
  group = augroup("DisableLineNumbersInTerminal", {}),
  pattern = "*",
})

-- Toggle relative numbers on/off conditionally
local create_relative_number_setter = function(value)
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
  callback = create_relative_number_setter(true),
  desc = "Enable relative numbers when returning to buffer and not in insert mode",
  group = augroup_toggle_relative_numbers,
  pattern = "*",
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave", }, {
  callback = create_relative_number_setter(false),
  desc = "Disable relative numbers when leaving buffer, in insert mode or in cmdline",
  group = augroup_toggle_relative_numbers,
  pattern = "*",
})

-- Disable auto-wrapping comments and disable inserting comment string after hitting 'o'.
-- Do this always on filetype to override settings from plugins
autocmd("FileType", {
  callback = function() vim.cmd("setlocal formatoptions-=c formatoptions-=o") end,
  desc = "Proper 'formatoptions'",
  group = augroup("ProperFormatOptions", {}),
  pattern = "*",
})

-- Run post-install tasks for packages. Packages can define a task function in their
-- spec.data.task that runs after install/update (but not delete).
-- Example usage: { data = { task = function(event) ... end } }
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local event_data = event.data
    local task = (event_data.spec.data or {}).task
    if event_data.kind ~= "delete" and type(task) == "function" then
      vim.nofity("Running task for package: " .. event_data.spec.name,
        vim.log.levels.INFO, { title = "Package Task", })
      pcall(task, event_data)
    end
  end,
  desc = "Run task with metadata for package if defined",
  group = augroup("RunTaskAfterPackageChanged", {}),
  pattern = "*",
})

-- Setup keybinding to delete from quicklist
autocmd("FileType", {
  callback = function(event)
    vim.keymap.set("n", "dd", function()
      local qflist = vim.fn.getqflist()
      if #qflist == 0 then
        return
      end

      local line = vim.fn.line(".")
      table.remove(qflist, line)
      vim.fn.setqflist({}, " ", { items = qflist, })

      local new_count = #qflist

      if new_count > 0 then
        local new_line = math.min(line, new_count)
        vim.api.nvim_win_set_cursor(0, { new_line, 0, })
      end
    end, {
      desc = "Delete from quickfix list",
      buffer = event.buf,
      silent = true,
    })
  end,
  desc = "Keybinding to delete from quicklist",
  group = augroup("QuickfixCfilterKeybinding", {}),
  pattern = "qf",
})
