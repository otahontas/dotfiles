local utils = require("utils")
local create_autogroup = utils.create_autogroup

create_autogroup("AutoApplyChezmoi", {
  "BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %"
})

create_autogroup("ChangeChezmoiTemplateFiletypes", {
  "BufNewFile,BufRead ~/local/share/chezmoi/**/*.tmpl let &filetype = expand('%:r:e')"
})
