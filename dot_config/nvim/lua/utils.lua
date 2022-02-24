map = function(mode, binding, command, extraOptions)
    local options = {noremap = true, silent = true}
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

create_autogroup = function(name, commands, opts)
    opts = opts or ""
    vim.api.nvim_command("augroup " .. name)
    vim.api.nvim_command("autocmd! " .. opts)
    for _, command in pairs(commands) do 
        vim.api.nvim_command("autocmd " .. command) 
    end
    vim.api.nvim_command("augroup END")
end

return {
    map = map,
    create_autogroup = create_autogroup
}
