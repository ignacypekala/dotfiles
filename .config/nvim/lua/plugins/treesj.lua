local github = require("utils.pack_providers").github

vim.pack.add({ github .. "Wansmer/treesj" })
local treesj = require('treesj')

treesj.setup({
    use_default_keymaps = false
})

vim.keymap.set("n", "<leader>m", treesj.toggle)
