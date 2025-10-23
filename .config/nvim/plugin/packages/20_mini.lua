require("utils").add_package({ "https://github.com/nvim-mini/mini.nvim", },
  function()
    -- Setup mini modules

    -- with default settings
    require("mini.git").setup()
    require("mini.icons").setup()
    require("mini.notify").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.surround").setup()

    -- with non-default settings
    require("mini.diff").setup({
      -- use signs always
      view = {
        style = "sign",
        signs = { add = "▒", change = "▒", delete = "▒", },
      },
    })
    require("mini.indentscope").setup({
      draw = {
        -- Skip animation
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })
  end)
