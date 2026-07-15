local combo = require('utils.combo')
local mod = require('preferences').mainMod
local programs = require('preferences').programs
local run_cmd = require('utils.run_cmd')

-- General
hl.bind(combo(mod, "SHIFT", "Q"), hl.dsp.window.close())
hl.bind(combo(mod, "SHIFT + P"), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Windows
hl.bind(combo(mod, "P"), hl.dsp.window.pseudo())
hl.bind(combo(mod, "T"), hl.dsp.layout("togglesplit"))

hl.bind(combo(mod, "Z"), hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(combo(mod, "F"), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(combo(mod, "V"), hl.dsp.window.float({ action = "toggle" }))

hl.bind(combo(mod, "R"), hl.dsp.exec_cmd(run_cmd(programs.menu)))
hl.bind(combo(mod, "E"), hl.dsp.exec_cmd(run_cmd(programs.fileManager)))
hl.bind(combo(mod, "N"), hl.dsp.exec_cmd(run_cmd(programs.terminal)))
hl.bind(combo(mod, "RETURN"), hl.dsp.exec_cmd(run_cmd(programs.terminal)))

hl.bind(combo(mod, "H"), hl.dsp.focus({ direction = "left" }))
hl.bind(combo(mod, "L"), hl.dsp.focus({ direction = "right" }))
hl.bind(combo(mod, "K"), hl.dsp.focus({ direction = "up" }))
hl.bind(combo(mod, "J"), hl.dsp.focus({ direction = "down" }))

hl.bind(combo(mod, "SHIFT", "H"), hl.dsp.window.move({ direction = "left" }))
hl.bind(combo(mod, "SHIFT", "L"), hl.dsp.window.move({ direction = "right" }))
hl.bind(combo(mod, "SHIFT", "K"), hl.dsp.window.move({ direction = "up" }))
hl.bind(combo(mod, "SHIFT", "J"), hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(combo(mod, key), hl.dsp.focus({ workspace = "m~" .. i }))
    hl.bind(combo(mod, "SHIFT", key), hl.dsp.window.move({ workspace = "m~" .. i }))
end

hl.bind(combo(mod, "G"), hl.dsp.focus({ workspace = "name:game" }))

-- Returns first available non-negative workspace ID. Needed because "emptynm" 
-- selector sometimes resolved to an empty workspace on a different monitor.
local get_next_free_workspace_id = function ()
    local workspaces = hl.get_workspaces()
    local max_id = math.mininteger
    for _, workspace in ipairs(workspaces) do
        if workspace.id > max_id then
            max_id = workspace.id
        end
    end
    local next_id = max_id + 1
    if max_id < 0 then
        next_id = 0
    end
    return next_id
end

hl.bind(combo(mod, "D"), function()
    hl.dispatch(hl.dsp.focus({ workspace = get_next_free_workspace_id() }))
end)

hl.bind(combo(mod, "SHIFT", "D"), function()
    hl.dsp.window.move({ workspace = get_next_free_workspace_id() })
end)

-- Focus empty workspaes on all monitors. Restore previous set of focused 
-- workspaces on next use.
local workspaces_before_minimize = {}
local focused_monitor_before_minimize = nil
hl.bind(combo(mod, "CTRL", "D"), function()
    local monitors_empty = true
    local monitors = hl.get_monitors()
    for _, monitor in ipairs(monitors) do
        local workspace_empty = monitor.active_workspace == nil or
            monitor.active_workspace.windows == 0
        if not workspace_empty then
            monitors_empty = false
        end
    end

    if (not monitors_empty) or next(workspaces_before_minimize) == nil then
        -- Minimize
        local current = hl.get_active_monitor()
        focused_monitor_before_minimize = current.id
        for _, monitor in ipairs(monitors) do
            workspaces_before_minimize[monitor.name] = monitor.active_workspace.id
            hl.dispatch(hl.dsp.focus({ monitor = monitor }))
            hl.dispatch(hl.dsp.focus({ workspace = get_next_free_workspace_id() }))
        end
        if current ~= nil then
            hl.dispatch(hl.dsp.focus({ monitor = current }))
        end
    else
        -- Restore
        for _, monitor in ipairs(monitors) do
            hl.dispatch(hl.dsp.focus({ monitor = monitor }))
            hl.dispatch(hl.dsp.focus({ workspace = workspaces_before_minimize[monitor.name] }))
        end
        workspaces_before_minimize = {}
        hl.dispatch(hl.dsp.focus({ monitor = focused_monitor_before_minimize }))
        focused_monitor_before_minimize = nil
    end
end)

hl.bind(combo(mod, "C"), hl.dsp.focus({ workspace = "emptynm" }))

hl.bind(combo(mod, "M"), hl.dsp.focus({ monitor = "+1" }))
hl.bind(combo(mod, "SHIFT", "M"), hl.dsp.window.move({ monitor = "+1"}))
hl.bind(combo(mod, "CTRL", "M"), hl.dsp.workspace.swap_monitors({ monitor1 = "0", monitor2 = "+1" }))

hl.bind(combo(mod, "SHIFT", "N"), hl.dsp.workspace.move({ workspace = "e+0", monitor = "+1"}))

hl.bind(combo(mod, "mouse_down"), hl.dsp.focus({ workspace = "m+1" }))
hl.bind(combo(mod, "TAB"), hl.dsp.focus({ workspace = "m+1" }))
hl.bind(combo(mod, "mouse_up"), hl.dsp.focus({ workspace = "m-1" }))

hl.bind(combo(mod, "SHIFT", "TAB"), hl.dsp.window.move({ workspace = "m-1" }))

-- Miscellaneous

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(combo(mod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(combo(mod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- silly vim addict side effect preventio-inator
hl.bind("CTRL + W", function()
    local window = hl.get_active_window()
    if window ~= nil then
        if window.class == programs.browser or window.class == "tidal-hifi" then
            hl.dispatch(hl.dsp.send_shortcut({
                mods = "CTRL",
                key = "BACKSPACE",
                window = window
            }))
        else
            -- Manual state management prevents issues with send_shortcut:
            -- https://github.com/hyprwm/Hyprland/discussions/14099
            hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = "W", state = "down" }))
            hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = "W", state = "up" }))
        end
    end
end, {repeating = true})
