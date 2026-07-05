hl.config({
    input = {
        kb_layout = "pl",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        repeat_delay = 300,
        repeat_rate = 25,

        follow_mouse = 2,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

local function register_mouse(acceleration)
    local name = "sinowealth-wired-gaming-mouse"
    if acceleration then
        hl.device({
            name = name,
            sensitivity = -0.5,
            accel_profile = ""
        })
    else
        hl.device({
            name = name,
            sensitivity = -0.2,
            accel_profile = "flat"
        })
    end
end

register_mouse(true)

hl.on("workspace.active", function (workspace)
    local accel = not (workspace ~= nil and workspace.name ~= nil and workspace.name == "game")
    register_mouse(accel)
end)

hl.device({
    name = "wacom-intuos-s-pen",
    output = "DP-2"
})
