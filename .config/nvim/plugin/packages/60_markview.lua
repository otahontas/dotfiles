require("utils").add_package({ "https://github.com/OXY2DEV/markview.nvim", },
  function()
    require("markview").setup({
      preview = {
        icon_provider = "mini",
      },
    })
  end)
