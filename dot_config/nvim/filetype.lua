-- Setup better filetypes (syntax etc) for some files
vim.filetype.add({
  extension = {
    conf = "conf",
    hook = "conf",
    rc = "conf",
  },
  filename = {
    config = "conf",
    ignore = "conf",
  },
})
