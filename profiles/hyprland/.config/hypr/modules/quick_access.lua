local combo = require('utils.combo')
local mod = require('preferences').mainMod
local run_cmd = require('utils.run_cmd')

local common_programs = {
    {
        class = "discord",
        workspace = "discord",
        app = "discord",
        key = "D"
    },
    {
        class = "steam",
        workspace = "steam",
        app = "steam",
        key = "G" -- Games
    },
    {
        class = "librewolf",
        workspace = "browser",
        app = "librewolf",
        key = "W" -- Web
    }
}

hl.define_submap("launch", "reset", function()
    for _, program in ipairs(common_programs) do
        local handler = function()
            local window = hl.get_window("class:" .. program.class)
            if window ~= nil then
                hl.dispatch(hl.dsp.focus({
                    window = window
                }))
            else
                hl.dispatch(hl.dsp.exec_cmd(run_cmd(program.app)))
            end
        end
        hl.bind(program.key, handler)
        hl.bind(combo(mod, program.key), handler)
        hl.bind("SHIFT + " .. program.key, handler)
    end
    hl.bind("catchall", function() end)
end)

hl.bind(combo(mod, "O"), hl.dsp.submap("launch"))
