return {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = 'VeryLazy',
    config = function()
        require('neoscroll').setup({
            duration_multiplier = 0.8,
            easing = 'quadratic'
        })
    end,
}
