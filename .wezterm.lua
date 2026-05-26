local wezterm = require('wezterm')
local config = wezterm.config_builder()
config.window_decorations = "TITLE | RESIZE"

config.initial_cols = 100
config.initial_rows = 30

config.bold_brightens_ansi_colors = false

config.colors = {
    background = "#121212",
    foreground = "#cccccc",
    ansi = {
        "#232323",
        "#d44d4f",
        "#67a376",
        "#f4c451",
        "#78a7f0",
        "#b575e9",
        "#4eccf2",
        "#b3b3b3",
    },
    brights = {
        "#5e5d5d",
        "#ed7375",
        "#9ae3ac",
        "#f9f1a5",
        "#8bc4f0",
        "#c59be7",
        "#9fd3ed",
        "#d6d6d6",
    },
    cursor_bg = "#cccccc",
    cursor_fg = "#121212",
    cursor_border = "#cccccc",
    selection_fg = '#d6d6d6',
    selection_bg = "#5e5d5d"
}

config.font_size =  12
config.font = wezterm.font('JetBrains Mono', { weight = "DemiBold" })
config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font('JetBrains Mono', { weight = "ExtraBold" })
    }
}

config.enable_tab_bar = false
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
config.adjust_window_size_when_changing_font_size = false

local act = wezterm.action
config.keys = {
    -- Send Control+Tab code
    {
        key = 'Tab',
        mods = 'CTRL',
        action = act.SendString('\x1b[27;5;9~'),
    },
    -- Map Control+Shift+Tab to Control+Shift+Left escape sequence
    {
        key = 'Tab',
        mods = 'CTRL|SHIFT',
        action = act.SendString('\x1b[1;6D'),
    },
}

return config
