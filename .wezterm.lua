local wezterm = require('wezterm')
local config = wezterm.config_builder()
config.window_decorations = "TITLE | RESIZE"

wezterm.on('format-window-title', function(tab)
    return tab.active_tab.title
end)

config.initial_cols = 120
config.initial_rows = 35


config.bold_brightens_ansi_colors = false

config.colors = {
    background = "#121212",
    foreground = "#cccccc",
    ansi = {
        "#202020",
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
    selection_fg = 'none',
    selection_bg = "#212121"
}

config.font_size =  10
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

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_thickness = 1

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
    -- Ctrl+B for home
    {
        key = 'b',
        mods = "CTRL",
        action = act.SendString('\x1b[H')
    },
    -- Ctrl+E for end
    {
        key = 'e',
        mods = "CTRL",
        action = act.SendString('\x1b[F')
    },
    -- Sends the escape sequence for Control + Delete
    {
        key = 'w',
        mods = 'CTRL',
        action = act.SendString('\x17'),
    },
    -- Alt+Shift+H/L (mapped to Ctrl+Shift+LEFT/RIGHT sequences)
    {
        key = 'H',
        mods = 'ALT|SHIFT',
        action = act.SendString('\x1b[1;5D')
    },
    {
        key = 'L',
        mods = 'ALT|SHIFT',
        action = act.SendString('\x1b[1;5C')
    },
    -- Alt+h/j/k/l (LEFT/UP/DOWN/RIGHT)
    {
        key = 'h',
        mods = 'ALT',
        action = act.SendString('\x1b[D')
    },
    {
        key = 'j',
        mods = 'ALT',
        action = act.SendString('\x1b[B'),
    },
    {
        key = 'k',
        mods = 'ALT',
        action = act.SendString('\x1b[A')
    },
    {
        key = 'l',
        mods = 'ALT',
        action = act.SendString('\x1b[C'),
    }
}

return config
