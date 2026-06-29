local dap = require('dap')
local file_picker = require('utils.file_picker')

-- Sets the executable or input_file variable 
local prompt_file = function (varname, displayname)
    file_picker.run(displayname, function (file)
        vim.g[varname] = file
    end)
end

-- User command configuration handler
-- Sets or prompts for a specific file
local set_or_prompt = function (payload)
    local varname = ''
    local displayname = ''
    if payload.name == "SetExecutable" or payload.name == "Sex" then
        varname = "debugee_executable"
        displayname = "executable"
    else
        varname = "debugee_input_file"
        displayname = "input file"
    end
    if payload.args == '' then
        prompt_file(varname, displayname)
    else
        vim.g[varname] = vim.fn.glob(payload.args)
    end
end
for _, name in ipairs({"SetExecutable", "Sex", "SetInputFile", "Sin"}) do
    vim.api.nvim_create_user_command(name, set_or_prompt, { nargs = "?" })
end

dap.configurations.c = {
    {
        name = "Debug C executable",
        type = "lldb",
        request = "launch",
        program = function()
            local executable = vim.g.debugee_executable
            if executable == nil or executable == '' then
                return coroutine.create(
                    function(dap_run_co)
                        file_picker.run("executable", function (file)
                            vim.g.debugee_executable = file
                            coroutine.resume(dap_run_co, file)
                        end)
                    end
                )
            end
            return vim.g.debugee_executable
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        stdio = function()
            local stdio = {
                nil,
                vim.fn.stdpath('log').."/lldb-dap-program.out",
                nil
            }
            local input_file = vim.g.debugee_input_file
            if input_file ~= nil then
                stdio[1] = input_file
            end
            return stdio
        end,
        args = { "0" }
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.asm = dap.configurations.c
