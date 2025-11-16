require("utils").add_package({ "https://github.com/pwntester/octo.nvim", },
  function()
    require("octo").setup({
      picker = "fzf-lua",
      file_panel = {
        use_icons = false, -- TODO: make a PR that allows using mini icons
      },
    })


    -- TODO: fix approving the review not working atm
    -- TODO: figure out way to go to next/prev changed line for easier review
    vim.keymap.set("n", "<leader>oca", "<cmd>Octo comment add<cr>", {
      desc = "Octo: add comment",
    })
  end)
