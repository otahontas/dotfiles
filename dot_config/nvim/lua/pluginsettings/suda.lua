local packageName = "lambdalisue/suda.vim"

local config = function()
  vim.g.suda_smart_edit = 1
end

return {
  packageName,
  config = config,
  commit = "6bffe36862faa601d2de7e54f6e85c1435e832d0",
}
