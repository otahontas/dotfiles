local wezterm = require("wezterm")
local io = require("io")
local os = require("os")

-- TODO: scandics not working, fix

local hyperlink_rules = {
  -- Linkify things that look like URLs
  -- This is actually the default if you don't specify any hyperlink_rules
  {
    regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
    format = "$0",
  },

  -- linkify email addresses
  {
    regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
    format = "mailto:$0",
  },

  -- file:// URI
  {
    regex = "\\bfile://\\S*\\b",
    format = "$0",
  },
}

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
  -- Retrieve the current viewport's text.
  local scrollback = pane:get_lines_as_text()

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, "w+")
  if f == nil then
    return
  end
  f:write(scrollback)
  f:flush()
  f:close()

  -- Open a new tab running nvim and tell it to open the file
  window:perform_action(
    wezterm.action({
      SpawnCommandInNewTab = {
        args = { "/usr/local/bin/nvim", name },
      },
    }),
    pane
  )

  -- wait "enough" time for nvim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous
  -- wrt. running this script and are not awaitable, so we just pick
  -- a number.  We don't strictly need to remove this file, but it
  -- is nice to avoid cluttering up the temporary file directory
  -- location.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

local keys = {
  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
  },
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
  },
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
  },
  {
    key = "h",
    mods = "LEADER | SHIFT",
    action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }),
  },
  {
    key = "j",
    mods = "LEADER | SHIFT",
    action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }),
  },
  {
    key = "k",
    mods = "LEADER | SHIFT",
    action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }),
  },
  {
    key = "l",
    mods = "LEADER | SHIFT",
    action = wezterm.action({ AdjustPaneSize = {
      "Right",
      5,
    } }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Left" }),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Down" }),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Up" }),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Right" }),
  },
  {
    key = ".",
    mods = "LEADER",
    action = wezterm.action({ EmitEvent = "trigger-nvim-with-scrollback" }),
  },
  {
    key = "n",
    mods = "LEADER",
    action = wezterm.action({ ActivateTabRelative = 1 }),
  },
  {
    key = "p",
    mods = "LEADER",
    action = wezterm.action({ ActivateTabRelative = -1 }),
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
  },
  {
    key = "f",
    mods = "LEADER",
    action = wezterm.action({ Search = { CaseSensitiveString = "" } }),
  },
  {
    key = "u",
    mods = "LEADER",
    action = wezterm.action({ ScrollByPage = -1 }),
  },
  {
    key = "d",
    mods = "LEADER",
    action = wezterm.action({ ScrollByPage = 1 }),
  },
  -- Add basic ctrl + c, ctrl + v from defaults
  {
    key = "c",
    mods = "SUPER",
    action = wezterm.action({ CopyTo = "Clipboard" }),
  },
  {
    key = "v",
    mods = "SUPER",
    action = wezterm.action({ PasteFrom = "Clipboard" }),
  },
}

return {

  -- TODO: load colorschema from different file
  colors = {
    foreground = "#0E1116",
    background = "#ffffff",
    ansi = {
      "#24292f",
      "#cf222e",
      "#116329",
      "#4d2d00",
      "#0969da",
      "#8250df",
      "#1b7c83",
      "#6e7781",
    },
    brights = {
      "#57606a",
      "#a40e26",
      "#1a7f37",
      "#633c01",
      "#218bff",
      "#a475f9",
      "#3192aa",
      "#8c959f",
    },
    indexed = { [16] = "#d18616", [17] = "#a40e26" },
  },
  disable_default_key_bindings = true,
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 14,
  hide_tab_bar_if_only_one_tab = true,
  hyperlink_rules = hyperlink_rules,
  keys = keys,
  leader = { key = "a", mods = "CTRL" },
  scrollback_lines = 5000,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 1,
  window_decorations = "RESIZE",
}
