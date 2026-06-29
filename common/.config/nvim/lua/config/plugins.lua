-- Loads the plugin configurations from lua/plugins
local plugin_files = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)

for _, file_path in ipairs(plugin_files) do
    local name = vim.fn.fnamemodify(file_path, ":t:r")
    local module_name = "plugins." .. name

    local ok, err = pcall(require, module_name)
    if not ok then
        vim.notify(
            "Plugin " .. module_name .. " failed to load.\n" .. err,
            vim.log.levels.ERROR
        )
    end
end
