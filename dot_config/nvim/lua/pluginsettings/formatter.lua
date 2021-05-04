-- Functions that return different formatters
local luaformatter = function()
    return {
        exe = "lua-format",
        args = {"-c", "$XDG_CONFIG_HOME/luaformatter/config.yaml"},
        stdin = true
    }
end

local black = function() return {exe = "black", args = {"-"}, stdin = true} end
-- TODO: setup to work with isort

local prettier = function()
    return {
        exe = "npx prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

local jq = function() return {exe = "jq", args = {"."}, stdin = true} end

local clang_format = function()
    return {
        exe = "clang-format",
        args = {"-style=\"{BasedOnStyle: google, IndentWidth: 4}\""},
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
        typecript = {prettier},
        cpp = {clang_format},
        json = {jq}
    }
})

-- Format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.js,*jsx,*.h,*.cpp,*.py,*.lua,*.json FormatWrite
augroup END
]], true)
