-- Automatically float specific windows

local events = {
    ["window.open"] = {
        {
            title = "Picture-in-Picture",
            dimensions = {
                x = 350, y = 200
            },
            position = { "down", "right" },
            focus = false
        }
    },
    ["window.title"] = {
        {
            title = "Extension: (Bitwarden Password Manager) - Bitwarden — LibreWolf",
            dimensions = {
                x = 400, y = 600
            },
            position = { "left", "up" },
            focus = true
        },
    }
}

for event, programs in pairs(events) do
    hl.on(event, function(w)
        -- Prevent subsequent auto-floats
        local tags = w.tags
        local auto_floated = false
        for _, tag in ipairs(tags) do
            if tag == "auto-floated" then
                auto_floated = true
                break
            end
        end

        if w ~= nil and not auto_floated then
            for _, program in ipairs(programs) do
                if w.title == program.title then

                    hl.dispatch(hl.dsp.window.float({
                        window = w,
                        action = "set",
                    }))

                    if program.dimensions ~= nil then
                        hl.dispatch(hl.dsp.window.resize({
                            window = w,
                            x = program.dimensions.x,
                            y = program.dimensions.y,
                        }))
                    end


                    if program.position ~= nil then
                        for _, direction in ipairs(program.position) do
                            hl.dispatch(hl.dsp.window.move({
                                window = w,
                                direction = direction
                            }))
                        end
                    end

                    if program.focus ~= nil and program.focus then
                        hl.dispatch(hl.dsp.focus({
                            window = w,
                        }))
                    end

                    hl.dispatch(hl.dsp.window.tag({
                        tag = "auto-floated"
                    }))

                    break
                end
            end
        end
    end)
end
