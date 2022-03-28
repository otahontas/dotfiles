local wezterm = require("wezterm")

return {
  color_scheme = "OneHalfLight",
  font = wezterm.font("Fira Code"),
  font_size = 14,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.97,
  window_decorations = "RESIZE",
  keys = {
    {
      key = "v",
      mods = "CTRL|ALT",
      action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    {
      key = "s",
      mods = "CTRL|ALT",
      action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
  },
}
