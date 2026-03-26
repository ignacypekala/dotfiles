local M = {}

-- Reads OUT filepath from a Makefile located at tthe root of the project
local function read_makefile_var(varname)
    local makefile = io.open("Makefile", "r")
    if not makefile then
        error("[dap] Makefile not found")
    end

    for line in makefile:lines() do
        -- Strip comments
        line = line:gsub("%s*#.*$", "")

        -- Match: OUT = value | OUT := value | OUT ?= value
        local out = line:match("^%s*".. varname .."%s*[:?]?=%s*(%S+)")
        if out then
            makefile:close()
            return out
        end
    end

    makefile:close()
    error("[dap]".. varname .."variable not found in Makefile")
end

function M.setup(dap)
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }
    dap.configurations.c = {
        {
            name = "Debug",
            type = "gdb",
            request = "launch",
            program = function()
                local out = read_makefile_var('OUT')
                vim.cmd('!make build-debug -s')
                return out
            end,
            args = function()
                local input = read_makefile_var('INPUT')
                print(input)
                return {"\\<", input}
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false
        }
    }
    dap.configurations.cpp = dap.configurations.c

end

return M
