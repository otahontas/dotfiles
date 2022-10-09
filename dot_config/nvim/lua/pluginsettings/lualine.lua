local packageName = "hoob3rt/lualine.nvim"

local requires = { "kyazdani42/nvim-web-devicons", opt = true }

local config = function()
  local function diff()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  require("lualine").setup({
    globalstatus = true,
    sections = {
      lualine_b = {
        { "b:gitsigns_head", icon = "" },
        { "diff", source = diff },
        "diagnostics",
      },
      lualine_c = {},
    },
    winbar = {
      lualine_a = {
        "filename",
      },
    },
    inactive_winbar = {
      lualine_a = {
        "filename",
      },
    },
    extensions = {
      "fugitive",
      "nvim-tree",
      "man",
      "quickfix",
    },
  })
end

return {
  packageName,
  requires = requires,
  config = config,
}
