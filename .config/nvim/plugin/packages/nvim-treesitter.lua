vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    data = {
      run = function() vim.cmd("TSUpdate") end,
    },
  }, }, {
  load = true,
  confirm = false,
})


local treesitter = require("nvim-treesitter")
local treesitter_packages = {
  "bash",
  "c",
  "comment", -- TODOs etc
  "ecma",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "html",
  "html_tags",
  "javascript",
  "json",
  "jsx",
  "latex",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "matlab",
  "python",
  "query",
  "sql",
  "ssh_config",
  "todotxt",
  "todotxt",
  "toml",
  "typescript",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "yaml"
}

treesitter.install(treesitter_packages)
vim.treesitter.language.register("yaml", "yaml.docker-compose")
vim.treesitter.language.register("yaml", "yaml.github-action")
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_packages,
  callback = function() vim.treesitter.start() end,
})
