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
  vim.keymap.set("n", "j", "gj", { buffer = bufnr })
  vim.keymap.set("n", "k", "gk", { buffer = bufnr })
end

return {
  create_autogroup = create_autogroup,
  setIndent = setIndent,
  disable_hard_wrap_for_buffer = disable_hard_wrap_for_buffer,
}
