local dap = require('dap')

-- Prompts user for a new debuggee executable
-- Returns 0 on success
local prompt_file = function(variable_name, display_name)
    local file = vim.g[variable_name]
    local prompt = "Enter the path for the "..display_name..": "
    if file == nil then
        file = vim.fn.input(
            prompt,
            vim.fn.getcwd() .. '/',
            'file'
        )
    else
        file = vim.fn.input(
            prompt,
            file,
            'file'
        )
    end
    if vim.fn.filereadable(file) == false then
        print("File "..file.." doesn't exist")
        return 1
    end
    vim.g[variable_name] = file
    return 0
end

local set_executable = function ()
    prompt_file('debugee_executable', 'executable')
end
vim.api.nvim_create_user_command('SetExecutable', set_executable, {
    desc = "Set executable for DAP"
})
vim.api.nvim_create_user_command('Sex', set_executable, {
    desc = "Set executable for DAP"
})

local set_inputfile = function ()
    prompt_file('debugee_input_file', 'input file')
end
vim.api.nvim_create_user_command('SetInputFile', set_inputfile, {
    desc = "Set input file for DAP"
})
vim.api.nvim_create_user_command('Sin', set_inputfile, {
    desc = "Set input file for DAP"
})

dap.configurations.c = {
    {
        name = "Debug C executable",
        type = "lldb",
        request = "launch",
        program = function()
            local executable = vim.g.debugee_executable
            if executable == nil then
                set_executable()
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

    },
}
