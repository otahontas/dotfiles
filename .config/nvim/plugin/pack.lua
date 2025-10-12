vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("BuildAfterPackge", { clear = false, }),
  pattern = "*",
  callback = function(event)
    local event_data = event.data
    local event_kind = event_data.kind
    local spec_data = event_data.spec.data or {}
    local task = spec_data.task
    if event_kind ~= "delete" and type(task) == "function" then
      pcall(task, event_data)
    end
  end,
})
