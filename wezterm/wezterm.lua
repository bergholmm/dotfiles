local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Material (Gogh)'

config.font = wezterm.font('IosevkaTerm Nerd Font')
config.font_size = 16

config.keys = {
  {
    key = 'P',
    mods = 'CTRL',
    action = wezterm.action.QuickSelectArgs({
      patterns = {
        'https?://\\S+',
      },
    }),
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },
}

config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true
config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
  tab_bar = {
    background = '#282828',
    active_tab = {
      bg_color = '#282828',
      fg_color = '#d4be98',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#1e1e1e',
      fg_color = '#918273',
    },
    inactive_tab_hover = {
      bg_color = '#1e1e1e',
      fg_color = '#918273',
    },
    new_tab = {
      bg_color = '#1e1e1e',
      fg_color = '#918273',
    },
    new_tab_hover = {
      bg_color = '#1e1e1e',
      fg_color = '#918273',
    },
  },
}

return config
