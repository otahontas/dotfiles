-- Setup better filetypes (syntax etc) for some files
vim.filetype.add({
  extension = {
    conf = "conf",
    hook = "conf",
    rc = "conf",
  },
  pattern = {
    ["docker%-compose%..*"] = "yaml.docker-compose",
    [".*/%.github/workflows/.*"] = "yaml.github-action",
    [".*/%.github/actions/.*"] = "yaml.github-action",
  },
  filename = {
    config = "conf",
    ignore = "conf",
  },
})
