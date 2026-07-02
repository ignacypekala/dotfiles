hl.config({
    input = {
        kb_layout    = "pl",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        -- Supposedly fixes an issue with a ghost backspace hold.
        repeat_delay = 300,
        repeat_rate = 35,

        follow_mouse = 2,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "sinowealth-wired-gaming-mouse",
    sensitivity = -0.5,
})

