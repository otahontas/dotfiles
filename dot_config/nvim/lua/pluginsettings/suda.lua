local packageName = "lambdalisue/suda.vim"

local config = function()
  vim.g.suda_smart_edit = 1
end

return { packageName, config = config }
