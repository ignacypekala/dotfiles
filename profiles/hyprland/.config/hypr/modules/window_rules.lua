-- hl.window_rule({
--     name           = "suppress-maximize-events",
--     match          = { class = ".*" },
--     suppress_event = "maximize",
-- })


-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "classify-steam-apps-as-games",
    match = { initial_class = "steam_app_\\d+" },
    content = "game"

})

hl.workspace_rule({
    workspace = "name:game",
    monitor = "DP-2"
})

hl.window_rule({
    name = "move-games-to-games-workspace",
    match = { content = "game" },
    workspace = "name:game",
    fullscreen = true,
})
