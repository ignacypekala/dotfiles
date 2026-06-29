-- Allows plugin declarations to define their build commands which are
-- automatically ran on package updates
local M = {}

local build_registry = {}

local build_group = vim.api.nvim_create_augroup("PackBuildHooks", { clear = true })

--- Internal autocommand to execute build steps on package changes.
--- Listens for the `PackChanged` event and runs the command or function
--- registered for the specific plugin.
vim.api.nvim_create_autocmd("PackChanged", {
    group = build_group,
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if kind == "delete" then return end

        local cmd = build_registry[name]
        if cmd then
            local install_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name

            if type(cmd) == "function" then
                vim.notify("Running the build function for " .. name .. "...", vim.log.levels.INFO)
                -- Safely execute the function and pass the installation path 
                local success, err = pcall(cmd, install_path)
                if success then
                    vim.notify(name .. " built successfully!", vim.log.levels.INFO)
                else
                    vim.notify("Failed to build " .. name .. ":\n" .. tostring(err), vim.log.levels.ERROR)
                end
            elseif type(cmd) == "table" then
                -- Execute the command table via vim.system
                vim.notify("Building " .. name .. " asynchronously.", vim.log.levels.INFO)
                vim.system(cmd, { cwd = install_path, text = true }, function(obj)
                    vim.schedule(function()
                        if obj.code == 0 then
                            vim.notify(name .. " built successfully!", vim.log.levels.INFO)
                        else
                            vim.notify("Failed to build " .. name .. ":\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
                        end
                    end)
                end)
            else
                vim.notify("Invalid build command type for " .. name .. ". Expected table or function.", vim.log.levels.WARN)
            end
        end
    end
})

--- Registers a build command or function to run when a plugin updates.
--- @param plugin_name string The exact name of the plugin (e.g., "telescope-fzf-native.nvim").
--- @param build_command table|function A command array for `vim.system` (e.g., {"make"}) or a callback function receiving the `install_path`.
function M.set_build_command(plugin_name, build_command)
    build_registry[plugin_name] = build_command
end

return M
