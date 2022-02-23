-- Some util functions for writing settings
local utils = {}

-- Set keybindings
utils.map = function(mode, binding, command, options)
    -- by default add these options
    local defaultoptions = {noremap = true, silent = true}
    local options = options or {}
    local finaloptions = {}
    for k, v in pairs(defaultoptions) do
        finaloptions[k] = v
    end
    for k, v in pairs(options) do
        if k ~= "noCR" then
            finaloptions[k] = v
        end
    end
    local suffix = "<CR>"
    if options.noCR then suffix = "" end
    vim.api.nvim_set_keymap(mode, binding, command .. suffix, finaloptions)
end

-- Create augroups easily
utils.create_autogroup = function(name, commands, opts)
    opts = opts or ""
    vim.api.nvim_command("augroup " .. name)
    vim.api.nvim_command("autocmd! " .. opts)
    for _, command in pairs(commands) do 
        vim.api.nvim_command("autocmd " .. command) 
    end
    vim.api.nvim_command("augroup END")
end

return utils
