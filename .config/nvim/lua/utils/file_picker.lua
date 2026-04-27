local M = {}
local telescope = {
    builtin = require("telescope.builtin"),
    finders = require("telescope.finders"),
    conf = require("telescope.config").values,
    actions = require("telescope.actions"),
    action_state = require("telescope.actions.state")
}

-- Prompts for a file and runs a callback with the specified location
function M.run(name, callback)
    telescope.builtin.find_files({
        prompt_title = "Select the "..name,
        attach_mappings = function(prompt_bufnr, _)
            telescope.actions.select_default:replace(function()
                telescope.actions.close(prompt_bufnr)
                local selection = telescope.action_state.get_selected_entry()
                local path = selection[1]
                callback(path)
            end)
            return true
        end,
        no_ignore = true;
    })
end

return M
