local utils = require("utils")
local create_autogroup = utils.create_autogroup

-- Auto apply chezmoi changes
create_autogroup("AutoApplyChezmoi", {
  "BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %",
})

-- Try to load better filetype for chezmoi template files
create_autogroup("ChangeChezmoiTemplateFiletypes", {
  "BufNewFile,BufRead ~/local/share/chezmoi/**/*.tmpl let &filetype = expand('%:r:e')",
})
