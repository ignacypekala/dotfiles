hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Make bitwarden prompts floating 
hl.on("window.title", function(w)
    if w ~= nil and w.title == "Extension: (Bitwarden Password Manager) - Bitwarden — LibreWolf" then
        hl.dispatch(hl.dsp.window.float({ action = "set" }))
    end
end)

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
