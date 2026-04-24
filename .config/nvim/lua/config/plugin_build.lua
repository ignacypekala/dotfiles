-- Allows plugin declarations to define their build commands which are
-- automatically ran on package updates
local M = {}

local build_registry = {}

local build_group = vim.api.nvim_create_augroup("PackBuildHooks", { clear = true })
vim.api.nvim_create_autocmd("PackChanged", {
    group = build_group,
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        
        if kind == "delete" then return end

        local cmd = build_registry[name]
        if cmd then
            local install_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name
            vim.notify("Building " .. name .. "...", vim.log.levels.INFO)

            vim.system(cmd, { cwd = install_path, text = true }, function(obj)
                vim.schedule(function()
                    if obj.code == 0 then
                        vim.notify(name .. " built successfully!", vim.log.levels.INFO)
                    else
                        vim.notify("Failed to build " .. name .. ":\n" .. obj.stderr, vim.log.levels.ERROR)
                    end
                end)
            end)
        end
    end
})

function M.set_build_command(plugin_name, build_command)
    build_registry[plugin_name] = build_command
end

return M
