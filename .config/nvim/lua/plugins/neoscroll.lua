local github = require("utils.pack_providers").github

vim.pack.add({
    github.."karb94/neoscroll.nvim"
})

require('neoscroll').setup({
    duration_multiplier = 0.7,
    easing = 'quadratic'
})
