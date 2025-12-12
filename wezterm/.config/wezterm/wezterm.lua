-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 15
config.line_height = 1.2
config.color_scheme = 'Catppuccin Mocha'

config.window_decorations = 'RESIZE'
config.enable_tab_bar = false

-- Key bindings
config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config
