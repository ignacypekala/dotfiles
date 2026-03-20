return {
    "karb94/neoscroll.nvim",
    lazy = true,
    enabled = true,
    event = 'VeryLazy',
    config = function()
        require('neoscroll').setup({
            duration_multiplier = 0.7,
            easing = 'quadratic'
        })
    end,
}
