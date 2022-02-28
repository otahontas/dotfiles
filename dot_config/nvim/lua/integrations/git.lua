local utils = require("utils")
local map = utils.map

-- Simple git wrapper
map("n", "<leader>G", ":!git ", { silent = false, suffix = "" })
