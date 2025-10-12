vim.filetype.add({
  extension = {
    gitconfig = "gitconfig",
  },
  pattern = {
    [".*/%.github/actions/.*"] = "yaml.github-action",
    [".*/%.github/workflows/.*"] = "yaml.github-action",
    ["docker%-compose%..*"] = "yaml.docker-compose",
    ["todo.txt"] = "todotxt"
  },
})
