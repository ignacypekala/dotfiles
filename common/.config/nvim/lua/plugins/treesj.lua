return {
    "treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
        { "<leader>j", desc = "Toggle split/join" },
    },
    after = function()
        local treesj = require('treesj')
        treesj.setup({
            use_default_keymaps = false,
            max_join_length = 200,
        })
        vim.keymap.set("n", "<leader>j", treesj.toggle)
    end
}
