local M = {}

---Set indent for filetype
---@param indent number
M.setIndent = function(indent)
  for _, option in ipairs({ "shiftwidth", "softtabstop", "tabstop", }) do
    vim.opt_local[option] = indent
  end
end

-- Disable hard wrap and move withing soft wrapped lines with j and k
---@param bufnr number the buffer to disable hard wrap for. 0 is the current buffer
M.disable_hard_wrap_for_buffer = function(bufnr)
  vim.opt_local.linebreak = true
  vim.opt_local.textwidth = 0
  vim.keymap.set("n", "j", "gj", { buffer = bufnr, })
  vim.keymap.set("n", "k", "gk", { buffer = bufnr, })
end

-- Get current directory, falling back cwd when current directory is not available
M.get_current_directory = function()
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    return vim.fn.getcwd()
  end
  return vim.fn.fnamemodify(current_file, ":h")
end


-- Get closest ancestor directory that has the given file, falling back to cwd when
-- current directory is not available
---@param filename string the file to look for
M.get_closest_ancestor_directory_that_has_file = function(filename)
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    return vim.fn.getcwd()
  end
  local dir = vim.fn.fnamemodify(current_file, ":h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/" .. filename) == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return vim.fn.getcwd() -- fallback to cwd if file not found
end
--

return M
