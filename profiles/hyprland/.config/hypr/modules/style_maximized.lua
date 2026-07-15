hl.window_rule({
    name = "style-maximized-windows",
    match = {
        fullscreen_state_client = 1 -- maximized
    },
    border_color = "#233726"
})

-- vim:filetype=lua
