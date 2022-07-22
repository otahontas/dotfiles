local packageName = "ethanholz/nvim-lastplace"

local config = function()
  require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
    lastplace_open_folds = true,
  })
end

return {
  packageName,
  config = config,
  commit = "ecced899435c6bcdd81becb5efc6d5751d0dc4c8",
}
