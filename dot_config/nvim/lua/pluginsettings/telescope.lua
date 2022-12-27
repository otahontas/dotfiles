local packageName = "nvim-telescope/telescope.nvim"

local requires = {
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
}

local config = function()
  local telescope = require("telescope")
  local default_config = require("telescope.config")

  local vimgrep_arguments = { unpack(default_config.values.vimgrep_arguments) }

  table.insert(vimgrep_arguments, "--follow")
  table.insert(vimgrep_arguments, "--hidden")
  table.insert(vimgrep_arguments, "--trim")

  vim.inspect(vimgrep_arguments)

  telescope.setup({
    defaults = {
      vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "file", "--strip-cwd-prefix", "--hidden" },
      },
    },
  })

  local builtin_pickers = require("telescope.builtin")
  vim.keymap.set("n", "<leader>tt", builtin_pickers.builtin, {})
  vim.keymap.set("n", "<leader>bb", builtin_pickers.buffers, {})
  vim.keymap.set("n", "<leader>km", builtin_pickers.keymaps, {})
  vim.keymap.set("n", "<leader>ge", builtin_pickers.diagnostics, {})
  vim.keymap.set("n", "<leader>ff", builtin_pickers.find_files, {})
  vim.keymap.set("n", "<leader>rg", builtin_pickers.live_grep, {})
  vim.keymap.set("n", "gd", builtin_pickers.lsp_definitions, {})
  vim.keymap.set("n", "gr", builtin_pickers.lsp_references, {})

  telescope.load_extension("fzf")
end

return {
  packageName,
  requires = requires,
  config = config,
}
