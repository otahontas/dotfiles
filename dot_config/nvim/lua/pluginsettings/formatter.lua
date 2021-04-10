-- Setup formatters for different filetypes
require("formatter").setup({
    logging = false,
    filetype = {
        lua = {
            function()
                return {
                    exe = "lua-format",
                    args = {"-c", "$XDG_CONFIG_HOME/luaformatter/config.yaml"},
                    stdin = true
                }
            end
        }
    }
})

-- Format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
augroup END
]], true)
