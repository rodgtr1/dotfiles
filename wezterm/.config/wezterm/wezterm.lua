-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local action = wezterm.action

wezterm.on('gui-startup', function(cmd)
  local screen = wezterm.gui.screens().active
  local ratio = 0.70
  local width = screen.width * ratio
  local height = screen.height * ratio
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():set_inner_size(width, height)
  window:gui_window():set_position((screen.width - width) / 2, (screen.height - height) / 2)
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 18
config.line_height = 1.2
config.color_scheme = 'Catppuccin Mocha'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.show_new_tab_button_in_tab_bar = false
config.window_padding = {
        bottom = 0,
        left = 10,
        right = 10,
}

-- Key bindings
config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.SendString 'clear\n',
  },
}

config.term = 'xterm-256color'

return config