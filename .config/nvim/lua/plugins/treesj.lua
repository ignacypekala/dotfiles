local github = require("utils.pack_providers").github

vim.pack.add({ github .. "Wansmer/treesj" })
local treesj = require('treesj')

treesj.setup({
    use_default_keymaps = false,
    max_join_length = 200,
})

vim.keymap.set("n", "<leader>j", treesj.toggle)
