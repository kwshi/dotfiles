local wezterm = require 'wezterm'

local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Dark']
scheme.background = '#282828'

return {
  use_fancy_tab_bar = false,
  default_prog = {"/bin/bash"},
  font = wezterm.font_with_fallback({
    'JuliaMono',
  }),
  visual_bell = {
    target = "BackgroundColor",
  },
  bold_brightens_ansi_colors = false,
  use_ime = true,
  font_size = 12,
  freetype_load_target = 'Light',
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 4, right = 4, top = 4, bottom = 4,
  },
  exit_behavior = "Close",
  color_schemes = {
    ['Gruvbox Dark'] = scheme,
  },
  color_scheme = 'Gruvbox Dark',
  keys = {
  },
}


