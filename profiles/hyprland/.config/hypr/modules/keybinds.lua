local mod = require('utils.mod')
local run_cmd = require('utils.run_cmd')

local terminal    = "wezterm"
local fileManager = "dolphin"
local menu        = "hyprlauncher"
local browser     = "librewolf"

hl.bind(mod("SHIFT", "Q"), hl.dsp.window.close())

hl.bind(mod("SHIFT + P"), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(mod("P"), hl.dsp.window.pseudo())
hl.bind(mod("T"), hl.dsp.layout("togglesplit"))

hl.bind(mod("Z"), hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod("F"), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod("V"), hl.dsp.window.float({ action = "toggle" }))

hl.bind(mod("R"), hl.dsp.exec_cmd(run_cmd(menu)))
hl.bind(mod("E"), hl.dsp.exec_cmd(run_cmd(fileManager)))
hl.bind(mod("N"), hl.dsp.exec_cmd(run_cmd(terminal)))
hl.bind(mod("RETURN"), hl.dsp.exec_cmd(run_cmd(terminal)))

hl.bind(mod("H"), hl.dsp.focus({ direction = "left" }))
hl.bind(mod("L"), hl.dsp.focus({ direction = "right" }))
hl.bind(mod("K"), hl.dsp.focus({ direction = "up" }))
hl.bind(mod("J"), hl.dsp.focus({ direction = "down" }))

hl.bind(mod("SHIFT", "H"), hl.dsp.window.move({ direction = "left" }))
hl.bind(mod("SHIFT", "L"), hl.dsp.window.move({ direction = "right" }))
hl.bind(mod("SHIFT", "K"), hl.dsp.window.move({ direction = "up" }))
hl.bind(mod("SHIFT", "J"), hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mod(key), hl.dsp.focus({ workspace = i }))
    hl.bind(mod("SHIFT", key), hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod("M"), hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod("SHIFT", "M"), hl.dsp.window.move({ monitor = "+1"}))
hl.bind(mod("CTRL", "M"), hl.dsp.workspace.swap_monitors({ monitor1 = "0", monitor2 = "+1" }))

-- Example special workspace (scratchpad)
hl.bind(mod("S"), hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod("SHIFT", "S"), hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod("SHIFT", "N"), hl.dsp.workspace.move({ workspace = "e+0", monitor = "+1"}))

-- TODO: workspace selector empty for the windows + D behaviour

hl.bind(mod("mouse_down"), hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mod("TAB"), hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mod("mouse_up"), hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mod("SHIFT", "TAB"), hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

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

hl.bind("CTRL + W", function()
    local window = hl.get_active_window()
    if window ~= nil then
        if window.class == browser then
            hl.dispatch(hl.dsp.send_shortcut({
                mods = "CTRL",
                key = "BACKSPACE",
                window = window
            }))
        else
            hl.dispatch(hl.dsp.pass({
                window = window
            }))
        end
    end
end)
