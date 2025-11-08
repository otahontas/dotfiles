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
local function tsort (sort_type)
  if sort_type ~= "due" and sort_type ~= "threshold" then
    vim.notify("Only 'due' and 'threshold' sort types are supported", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indexed_lines = {}

  -- Extract dates based on sort type
  local pattern = sort_type == "due" and "due:(%d%d%d%d%-%d%d%-%d%d)" or "t:(%d%d%d%d%-%d%d%-%d%d)"
  for _, line in ipairs(lines) do
    local date = line:match(pattern)
    table.insert(indexed_lines, {
      line = line,
      date = date or "",
    })
  end

  -- Sort: dates first (chronologically), then alphabetically
  table.sort(indexed_lines, function(a, b)
    if a.date ~= b.date then
      if a.date == "" then
        return false -- no date goes last
      elseif b.date == "" then
        return true -- no date goes last
      else
        return a.date < b.date -- chronological order
      end
    else
      return a.line < b.line -- alphabetical order
    end
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
    return { "due", "threshold" }
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
