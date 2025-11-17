local utils = require("utils")
utils.disable_hard_wrap_for_buffer(0)

-- Spellcheck for todotxt files
vim.opt_local.spell = true

-- toggle done with commentstring
vim.bo.commentstring = "x %s"

-- Date patterns
local PATTERNS = {
  due = "due:(%d%d%d%d%-%d%d%-%d%d)",
  threshold = "t:(%d%d%d%d%-%d%d%-%d%d)",
  completed = "^x %d%d%d%d%-%d%d%-%d%d",
}

-- Valid sort types
local VALID_SORT_TYPES = { due = true, threshold = true, project = true, context = true, }

-- Cache today's date
local today = os.date("%Y-%m-%d")

-- Highlight overdue and active threshold dates
local due_match_id = nil
local threshold_match_id = nil

local function highlight_dates ()
  -- Clear existing highlights
  if due_match_id then
    pcall(vim.fn.matchdelete, due_match_id)
    due_match_id = nil
  end
  if threshold_match_id then
    pcall(vim.fn.matchdelete, threshold_match_id)
    threshold_match_id = nil
  end

  today = os.date("%Y-%m-%d") -- Refresh cached date
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local due_positions = {}
  local threshold_positions = {}

  for lnum, line in ipairs(lines) do
    -- Skip completed tasks
    if line:match(PATTERNS.completed) then
      goto continue
    end

    -- Check for overdue tasks
    local due_start, due_end, date = line:find(PATTERNS.due)
    if date and date <= today then
      table.insert(due_positions, { lnum, due_start, due_end - due_start + 1, })
    end

    -- Check for active threshold dates
    local t_start, t_end, date = line:find(PATTERNS.threshold)
    if date and date <= today then
      table.insert(threshold_positions, { lnum, t_start, t_end - t_start + 1, })
    end

    ::continue::
  end

  if #due_positions > 0 then
    due_match_id = vim.fn.matchaddpos("ErrorMsg", due_positions, 10)
  end
  if #threshold_positions > 0 then
    threshold_match_id = vim.fn.matchaddpos("DiagnosticInfo", threshold_positions, 10)
  end
end

-- Tag helpers
local function find_next_tag_span (line, start_index)
  local search_start = start_index or 1
  while true do
    local tag_start, tag_end = line:find("([%w_%-]+:%S+)", search_start)
    if not tag_start then return nil end

    local preceding_ok = tag_start == 1
    if not preceding_ok then
      local before_char = line:sub(tag_start - 1, tag_start - 1)
      preceding_ok = before_char:match("%s") ~= nil
    end

    if preceding_ok then return tag_start, tag_end end
    search_start = tag_end + 1
  end
end

local function insert_token_before (line, index, token)
  local prefix = line:sub(1, index - 1)
  local suffix = line:sub(index)
  local before_gap = (prefix == "" or prefix:match("%s$")) and "" or " "
  local after_gap = (suffix == "" or suffix:match("^%s")) and "" or " "
  return prefix .. before_gap .. token .. after_gap .. suffix
end

local function insert_token_after (line, index, token)
  local prefix = line:sub(1, index)
  local suffix = line:sub(index + 1)
  local before_gap = (prefix == "" or prefix:match("%s$")) and "" or " "
  local after_gap = (suffix == "" or suffix:match("^%s")) and "" or " "
  return prefix .. before_gap .. token .. after_gap .. suffix
end

-- Adjust due date on current line
local function insert_due_before_first_tag (line, new_date)
  local due_token = "due:" .. new_date
  local tag_start = find_next_tag_span(line, 1)
  if tag_start then return insert_token_before(line, tag_start, due_token) end

  local trailing_gap = (line == "" or line:match("%s$")) and "" or " "
  return line .. trailing_gap .. due_token
end

local function insert_threshold_as_second_tag (line, new_date)
  local threshold_token = "t:" .. new_date
  local due_start, due_end = line:find("due:%d%d%d%d%-%d%d%-%d%d")
  if due_start then return insert_token_after(line, due_end, threshold_token) end

  local first_tag_start, first_tag_end = find_next_tag_span(line, 1)
  if first_tag_start then
    return insert_token_after(line, first_tag_end, threshold_token)
  end

  local trailing_gap = (line == "" or line:match("%s$")) and "" or " "
  return line .. trailing_gap .. threshold_token
end

local function adjust_due_date (delta)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  local pattern = "due:(%d%d%d%d%-%d%d%-%d%d)"
  local current_due = line:match(pattern)

  local base_date = current_due or os.date("%Y-%m-%d")
  local year, month, day = base_date:match("(%d+)%-(%d+)%-(%d+)")
  if not (year and month and day) then return end

  local timestamp = os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
  })
  timestamp = timestamp + delta * 24 * 60 * 60
  local new_date = os.date("%Y-%m-%d", timestamp)

  if current_due then
    line = line:gsub("due:%d%d%d%d%-%d%d%-%d%d", "due:" .. new_date, 1)
  else
    line = insert_due_before_first_tag(line, new_date)
  end

  vim.api.nvim_buf_set_lines(0, row - 1, row, false, { line, })
  highlight_dates()
end

local function adjust_threshold_date (delta)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  local pattern = "t:(%d%d%d%d%-%d%d%-%d%d)"
  local current_threshold = line:match(pattern)

  local base_date = current_threshold or os.date("%Y-%m-%d")
  local year, month, day = base_date:match("(%d+)%-(%d+)%-(%d+)")
  if not (year and month and day) then return end

  local timestamp = os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
  })
  timestamp = timestamp + delta * 24 * 60 * 60
  local new_date = os.date("%Y-%m-%d", timestamp)

  if current_threshold then
    line = line:gsub("t:%d%d%d%d%-%d%d%-%d%d", "t:" .. new_date, 1)
  else
    line = insert_threshold_as_second_tag(line, new_date)
  end

  vim.api.nvim_buf_set_lines(0, row - 1, row, false, { line, })
  highlight_dates()
end

local function map_date_delta (lhs, delta, fn, desc)
  vim.keymap.set("n", lhs, function()
    fn(delta)
  end, { buffer = 0, desc = desc, })
end

map_date_delta("<space>dm", -1, adjust_due_date, "Decrease due date by 1 day")
map_date_delta("<space>dp", 1, adjust_due_date, "Increase due date by 1 day")
map_date_delta("<space>tm", -1, adjust_threshold_date, "Decrease threshold date by 1 day")
map_date_delta("<space>tp", 1, adjust_threshold_date, "Increase threshold date by 1 day")

-- Sort todo.txt by various criteria
local function tsort (sort_spec)
  -- Parse sort specification (e.g., "due,threshold" or just "due")
  local parts = vim.split(sort_spec, ",", { plain = true, })
  local primary = vim.trim(parts[1])
  local secondary = parts[2] and vim.trim(parts[2]) or nil

  -- Validate sort types
  if not VALID_SORT_TYPES[primary] then
    vim.notify(
      "Invalid primary sort type. Use 'due', 'threshold', 'project', or 'context'",
      vim.log.levels.WARN)
    return
  end
  if secondary and not VALID_SORT_TYPES[secondary] then
    vim.notify(
      "Invalid secondary sort type. Use 'due', 'threshold', 'project', or 'context'",
      vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indexed_lines = {}

  -- Get pattern for a sort type
  local function get_pattern (sort_type)
    if sort_type == "due" then return "due:(%d%d%d%d%-%d%d%-%d%d)" end
    if sort_type == "threshold" then return "t:(%d%d%d%d%-%d%d%-%d%d)" end
    if sort_type == "project" then return "%+(%S+)" end
    if sort_type == "context" then return "@(%S+)" end
  end

  local primary_pattern = get_pattern(primary)
  local secondary_pattern = secondary and get_pattern(secondary) or nil

  for _, line in ipairs(lines) do
    local primary_value = line:match(primary_pattern) or ""
    local secondary_value = secondary_pattern and (line:match(secondary_pattern) or "") or
      nil

    table.insert(indexed_lines, {
      line = line,
      primary = primary_value,
      secondary = secondary_value,
    })
  end

  -- Helper to compare values (empty values go last)
  local function compare_values (a, b)
    if a == "" and b == "" then return false end
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
local augroup = vim.api.nvim_create_augroup("TodoTxtHighlight", { clear = true, })
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave", "TextChanged", }, {
  group = augroup,
  buffer = 0,
  callback = highlight_dates,
})

-- Initial highlight
highlight_dates()
