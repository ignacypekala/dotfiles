local mod = require('utils.mod')
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

for _, program in ipairs(common_programs) do
    local workspace_name = "name:" .. program.workspace
    hl.window_rule({
        name = "automove to " .. program.workspace .. " workspace",
        match = {
            initial_class = program.class
        },
        workspace = workspace_name
    })
    hl.bind(mod(program.key), function()
        local window = hl.get_window("class:" .. program.class)
        if window ~= nil then
            hl.dispatch(hl.dsp.focus({ workspace = workspace_name }))
        else
            hl.dispatch(hl.dsp.exec_cmd(run_cmd(program.app)))
        end
    end)

end
