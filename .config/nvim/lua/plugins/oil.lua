local github = require("utils.pack_providers").github

vim.pack.add({
    github .. "stevearc/oil.nvim",
    github .. "nvim-mini/mini.icons"
})
require("mini.icons").setup({})
require('oil').setup({})
vim.keymap.set(
    "n", "-",
    "<CMD>Oil<CR>",
    { desc = "Open parent directory" }
)
