-- Functions that return different formatters
local luaformatter = function()
    return {
        exe = "lua-format",
        args = {"-c", "$XDG_CONFIG_HOME/luaformatter/config.yaml"},
        stdin = true
    }
end

local black = function() return {exe = "black", args = {"-"}, stdin = true} end

local prettier = function()
    return {
        exe = "npx prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

-- Setup formatters for different filetypes
require("formatter").setup({
    logging = false,
    filetype = {
        lua = {luaformatter},
        python = {black},
        javascript = {prettier},
        typecript = {prettier}
    }
})

-- Format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.lua FormatWrite
augroup END
]], true)
