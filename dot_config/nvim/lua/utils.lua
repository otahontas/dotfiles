-- Autogroup helper
local create_autogroup = function(name, commands, opts)
  opts = opts or ""
  vim.api.nvim_command("augroup " .. name)
  vim.api.nvim_command("autocmd! " .. opts)
  for _, command in pairs(commands) do
    vim.api.nvim_command("autocmd " .. command)
  end
  vim.api.nvim_command("augroup END")
end

-- Create keymappings
local map = function(mode, binding, command, extraOptions)
  local options = { noremap = true, silent = true }
  local suffix = "<CR>"
  extraOptions = extraOptions or {}
  for option, value in pairs(extraOptions) do
    if option == "suffix" then
      suffix = value
    else
      options[option] = value
    end
  end
  vim.api.nvim_set_keymap(mode, binding, command .. suffix, options)
end

local buf_map = function(bufnr, mode, binding, command, extraOptions)
  local options = { noremap = true, silent = true }
  local suffix = "<CR>"
  extraOptions = extraOptions or {}
  for option, value in pairs(extraOptions) do
    if option == "suffix" then
      suffix = value
    else
      options[option] = value
    end
  end
  vim.api.nvim_buf_set_keymap(bufnr, mode, binding, command .. suffix, options)
end

---Set indent for filetype
---@param indent number
local setIndent = function(indent)
  for _, option in ipairs({ "shiftwidth", "softtabstop", "tabstop" }) do
    vim.opt_local[option] = indent
  end
end

-- Disable hard wrap and move withing soft wrapped lines with j and k
---@param bufnr number the buffer to disable hard wrap for. 0 is the current buffer if calling from "inside the buffer", e.g. ftplugin or autocmd.
local disable_hard_wrap_for_buffer = function(bufnr)
  vim.opt_local.linebreak = true
  vim.opt_local.textwidth = 0
  buf_map(bufnr, "", "j", "gj", { suffix = "" })
  buf_map(bufnr, "", "k", "gk", { suffix = "" })
end

return {
  create_autogroup = create_autogroup,
  map = map,
  setIndent = setIndent,
  buf_map = buf_map,
  disable_hard_wrap_for_buffer = disable_hard_wrap_for_buffer,
}
