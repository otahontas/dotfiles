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

return utils
