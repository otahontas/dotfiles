local packageName = "ahmedkhalf/project.nvim"

local config = function()
  require("project_nvim").setup({})
  require("telescope").load_extension("projects")
end

return { packageName, config = config }
