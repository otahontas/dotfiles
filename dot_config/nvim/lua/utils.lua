-- Some util functions for writing settings
local utils = {}

-- Set keybindings
utils.map = function(mode, binding, command)
    -- by default add these options
    local options = {noremap = true, silent = true}
    -- by default, append enter prefix to end of command
    local suffix = "<CR>"
    vim.api.nvim_set_keymap(mode, binding, command .. suffix, options)
end

-- Create augroups easily
utils.create_autogroup = function(name, commands, opts)
    opts = opts or ""
    vim.api.nvim_command("augroup " .. name)
    vim.api.nvim_command("autocmd! " .. opts)
    for _, command in pairs(commands) do vim.api.nvim_command("autocmd " .. command) end
    vim.api.nvim_command("augroup END")
end

return utils
