require("utils").add_package({ "https://github.com/pwntester/octo.nvim", },
  function()
    require("octo").setup({
      picker = "fzf-lua",
      file_panel = {
        use_icons = false, -- TODO: make a PR that allows using mini icons
      },
    })
  end)
