local packageName = "github/copilot.vim"

local run = ":Copilot setup"

return {
  packageName,
  run = run,
}

-- TODO: Add support for ALT-[ and ALT-] keybindings on MacOS. See: https://github.com/github/copilot.vim/commit/47eb231463d3654de1a205c4e30567fbd006965d#commitcomment-67096927
