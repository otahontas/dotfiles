---Set indent for filetype
---@param indent number
local setIndent = function(indent)
  for _, option in ipairs({ "shiftwidth", "softtabstop", "tabstop" }) do
    vim.opt_local[option] = indent
  end
end

-- Disable hard wrap and move withing soft wrapped lines with j and k
---@param bufnr number the buffer to disable hard wrap for. 0 is the current buffer
local disable_hard_wrap_for_buffer = function(bufnr)
  vim.opt_local.linebreak = true
  vim.opt_local.textwidth = 0
  vim.keymap.set("n", "j", "gj", { buffer = bufnr })
  vim.keymap.set("n", "k", "gk", { buffer = bufnr })
end

return {
  setIndent = setIndent,
  disable_hard_wrap_for_buffer = disable_hard_wrap_for_buffer,
}
