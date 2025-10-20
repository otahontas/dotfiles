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
  "comment", -- TODOs etc
  "gitcommit",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "typescript",
  "todotxt"
}
treesitter.install(treesitter_packages)
vim.treesitter.language.register("yaml", "yaml.docker-compose")
vim.treesitter.language.register("yaml", "yaml.github-action")
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_packages,
  callback = function() vim.treesitter.start() end,
})
