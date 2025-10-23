-- Custom filetype definitions, loaded when filetype is on
vim.filetype.add({
  pattern = {
    -- yaml.github-action & yaml.docker-compose needed for proper treesitter, lsp and
    -- formatter setups
    [".*/%.github/actions/.*"] = "yaml.github-action",
    [".*/%.github/workflows/.*"] = "yaml.github-action",
    ["docker%-compose%..*"] = "yaml.docker-compose",
    -- Needed for proper treesitter setup
    ["todo.txt"] = "todotxt",
  },
})
