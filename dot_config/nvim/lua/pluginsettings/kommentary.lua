local config = require("kommentary.config")

-- Add extended mappings
config.use_extended_mappings()

-- Setup some better defaults
config.configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true
})
