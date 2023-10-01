-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("DisableLineNumbersInTerminal", {}),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Use relative numbers for current buffer in normal mode, otherwise normal numbers
local relative_numbers_augroup =
  vim.api.nvim_create_augroup("ToggleRelativeNumbers", {})
vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
  {
    pattern = "*",
    group = relative_numbers_augroup,
    callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
        vim.opt_local.relativenumber = true
      end
    end,
  }
)
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
  {
    pattern = "*",
    group = relative_numbers_augroup,
    callback = function()
      if vim.o.nu then
        vim.opt_local.relativenumber = false
        vim.cmd("redraw")
      end
    end,
  }
)

-- Create missing directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("CreateMissingDirectoriesOnSave", {}),
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
