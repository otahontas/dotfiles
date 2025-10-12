return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      -- TODO: replace with lazydev
      workspace = {
        library = vim.tbl_filter(function(d)
          return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
        end, vim.api.nvim_get_runtime_file("", true)),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          continuation_indent = "2",
          quote_style = "double",
          max_line_length = "88",
          trailing_table_separator = "always",
        },
      },
    },
  },
}
