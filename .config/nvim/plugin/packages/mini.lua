vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
  },
}, {
  load = true,
  confirm = false,
})

-- default settings
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.ai").setup()
require("mini.bufremove").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.sessions").setup()
require("mini.git").setup()

-- extra settings
require("mini.indentscope").setup({
  draw = {
    -- Skip animation
    animation = require("mini.indentscope").gen_animation.none(),
  },
})
require("mini.diff").setup({
  -- use signs always
  view = {
    style = "sign",
    signs = { add = "▒", change = "▒", delete = "▒", },
  },
})
