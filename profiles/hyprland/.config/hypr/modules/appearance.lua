hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 1,
        col = {
            active_border = {
                colors = {
                    "#67a376bb",
                },
            },
            inactive_border = "#191919",
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity  = 1.0,
        inactive_opacity = 0.95,
        blur = {
            enabled  = true,
        },

        dim_inactive = true,
        dim_strength = 0.05,

        shadow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = "#121212ee"
        },
    },
})

-- vim:filetype=lua
