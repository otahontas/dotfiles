local utils = require("utils")
utils.disable_hard_wrap_for_buffer(0)

-- Spellcheck for todotxt files
vim.opt_local.spell = true

-- toggle done with commentstring
vim.bo.commentstring = "x %s"

-- Highlight overdue and active threshold dates
local due_match_id = nil
local threshold_match_id = nil

local function highlight_dates()
  -- Clear existing highlights
  if due_match_id then
    pcall(vim.fn.matchdelete, due_match_id)
    due_match_id = nil
  end
  if threshold_match_id then
    pcall(vim.fn.matchdelete, threshold_match_id)
    threshold_match_id = nil
  end

  local today = os.date("%Y-%m-%d")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local due_positions = {}
  local threshold_positions = {}

  for lnum, line in ipairs(lines) do
    -- Check for overdue tasks
    local due_start, due_end, due_date = line:find("(due:%d%d%d%d%-%d%d%-%d%d)")
    if due_date then
      local date = due_date:match("due:(%d%d%d%d%-%d%d%-%d%d)")
      if date and date <= today then
        table.insert(due_positions, {lnum, due_start, due_end - due_start + 1})
      end
    end

    -- Check for active threshold dates
    local t_start, t_end, t_date = line:find("(t:%d%d%d%d%-%d%d%-%d%d)")
    if t_date then
      local date = t_date:match("t:(%d%d%d%d%-%d%d%-%d%d)")
      if date and date <= today then
        table.insert(threshold_positions, {lnum, t_start, t_end - t_start + 1})
      end
    end
  end

  if #due_positions > 0 then
    due_match_id = vim.fn.matchaddpos("ErrorMsg", due_positions, 10)
  end
  if #threshold_positions > 0 then
    threshold_match_id = vim.fn.matchaddpos("DiagnosticInfo", threshold_positions, 10)
  end
end

-- Sort todo.txt by various criteria
local function tsort (sort_spec)
  -- Parse sort specification (e.g., "due,threshold" or just "due")
  local parts = vim.split(sort_spec, ",", { plain = true })
  local primary = vim.trim(parts[1])
  local secondary = parts[2] and vim.trim(parts[2]) or nil

  -- Validate sort types
  local valid_types = { due = true, threshold = true, project = true, context = true }
  if not valid_types[primary] then
    vim.notify("Invalid primary sort type. Use 'due', 'threshold', 'project', or 'context'", vim.log.levels.WARN)
    return
  end
  if secondary and not valid_types[secondary] then
    vim.notify("Invalid secondary sort type. Use 'due', 'threshold', 'project', or 'context'", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indexed_lines = {}

  -- Get pattern for a sort type
  local function get_pattern(sort_type)
    if sort_type == "due" then return "due:(%d%d%d%d%-%d%d%-%d%d)" end
    if sort_type == "threshold" then return "t:(%d%d%d%d%-%d%d%-%d%d)" end
    if sort_type == "project" then return "%+(%S+)" end
    if sort_type == "context" then return "@(%S+)" end
  end

  local primary_pattern = get_pattern(primary)
  local secondary_pattern = secondary and get_pattern(secondary) or nil

  for _, line in ipairs(lines) do
    local primary_value = line:match(primary_pattern) or ""
    local secondary_value = secondary_pattern and (line:match(secondary_pattern) or "") or nil

    table.insert(indexed_lines, {
      line = line,
      primary = primary_value,
      secondary = secondary_value,
    })
  end

  -- Helper to compare values (empty values go last)
  local function compare_values(a, b)
    if a == "" and b == "" then return nil end
    if a == "" then return false end
    if b == "" then return true end
    return a < b
  end

  -- Sort with optional secondary value
  table.sort(indexed_lines, function(a, b)
    -- Primary sort
    if a.primary ~= b.primary then
      local result = compare_values(a.primary, b.primary)
      if result ~= nil then return result end
    end

    -- Secondary sort (if specified)
    if secondary and a.secondary ~= b.secondary then
      local result = compare_values(a.secondary, b.secondary)
      if result ~= nil then return result end
    end

    -- Tertiary: alphabetical
    return a.line < b.line
  end)

  -- Extract sorted lines
  local sorted_lines = {}
  for _, item in ipairs(indexed_lines) do
    table.insert(sorted_lines, item.line)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, sorted_lines)
  highlight_dates()
end

vim.api.nvim_buf_create_user_command(0, "Sort", function(opts)
  tsort(opts.args)
end, {
  nargs = 1,
  complete = function()
    return {
      "due",
      "due,threshold",
      "threshold",
      "threshold,due",
      "project",
      "project,due",
      "context",
      "context,due",
    }
  end,
})

-- Set up autocommands to refresh highlights
local augroup = vim.api.nvim_create_augroup("TodoTxtHighlight", { clear = true })
vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave", "TextChanged"}, {
  group = augroup,
  buffer = 0,
  callback = highlight_dates,
})

-- Initial highlight
highlight_dates()
