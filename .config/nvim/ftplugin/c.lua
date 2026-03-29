local dap = require('dap')
local telescope = {
    builtin = require("telescope.builtin"),
    finders = require("telescope.finders"),
    conf = require("telescope.config").values,
    actions = require("telescope.actions"),
    action_state = require("telescope.actions.state")
}

-- Prompts for a file and saves the location to a global variable
local prompt_file = function(variable_name, display_name)
    telescope.builtin.find_files({
        prompt_title = "Select the "..display_name,
        attach_mappings = function(prompt_bufnr, _)
            telescope.actions.select_default:replace(function()
                telescope.actions.close(prompt_bufnr)
                local selection = telescope.action_state.get_selected_entry()
                local path = selection[1]
                vim.g[variable_name] = path
            end)
            return true
        end,
    })
end

-- Sets the executable or input_file variable 
-- 
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
            if executable == nil then
                prompt_file('debugee_executable', 'executable')
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
