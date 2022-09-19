local packageName = "b3nj5m1n/kommentary"

local config = function()
  require("kommentary.config").configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true,
  })
end

return {
  packageName,
  config = config,
}
